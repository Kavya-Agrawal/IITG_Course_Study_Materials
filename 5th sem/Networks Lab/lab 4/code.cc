// packet_sched_sim.cpp
// g++ -std=c++17 -O2 -pthread -o packet_sched_sim packet_sched_sim.cpp
//
// Usage: ./packet_sched_sim input.txt MODE
// MODE = WFQ or FCFS
//
// Example: ./packet_sched_sim inputA.txt WFQ

#include <bits/stdc++.h>
#include <fstream>
#include <vector>
#include <queue>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <random>
#include <chrono>
#include <iomanip>
#include <atomic>
#include <algorithm>
#include <cmath>

using namespace std;

// ---------- SIM CONFIG ----------
static constexpr double SIM_SPEEDUP = 0.001; // multiply simulated seconds -> real seconds

// ---------- Data structures ----------
struct Packet {
    uint64_t id;
    int src;
    int size; // bytes
    double gen_time; // simulated seconds
    double enq_time; // time when actually enqueued (sim)
    double tx_start_time;
    double tx_end_time;
    double finish; // used by WFQ
};

struct SourceCfg {
    double P; // packets/sec
    int Lmin, Lmax;
    double w; // weight
    double tb, te; // fraction of T (0..1)
};

int N;
double T_sim; // total simulated seconds
double C_bps; // link capacity (bytes/sec)
int B_cap;    // queue capacity (packets)

vector<SourceCfg> sources;
atomic<uint64_t> global_packet_id{0};

mutex q_mtx;
condition_variable q_cv;
atomic<bool> stop_all{false};

deque<shared_ptr<Packet>> fcfs_queue;
multiset<pair<double, shared_ptr<Packet>>> wfq_set;

// stats
atomic<uint64_t> total_generated{0}, total_dropped{0}, total_transmitted{0};
atomic<uint64_t> transmitted_bytes{0};

// per-source counters (atomics)
vector<atomic<uint64_t>> transmitted_bytes_per_src;
vector<atomic<uint64_t>> generated_per_src;
vector<atomic<uint64_t>> dropped_per_src;

vector<double> last_finish; // per-source last finish (WFQ)

mutex stats_mtx;
vector<double> delays;
vector<shared_ptr<Packet>> transmitted_packets;

enum Mode { MODE_WFQ, MODE_FCFS };
Mode schedule_mode = MODE_WFQ;

// ---------- RNG helpers ----------
// Use thread-local RNG so multiple source threads do not concurrently touch the same engine.
thread_local std::mt19937_64 rng_engine((uint64_t)std::chrono::steady_clock::now().time_since_epoch().count() ^ (uintptr_t)&rng_engine);

double uniform_rand(double a, double b) {
    std::uniform_real_distribution<double> unif(a,b);
    return unif(rng_engine);
}
double exp_rand(double lambda) {
    double u = uniform_rand(0.0,1.0);
    return -log(max(1e-12, u)) / lambda;
}

void sleep_sim(double sim_seconds) {
    if (sim_seconds <= 0) return;
    auto real_ms = sim_seconds * SIM_SPEEDUP * 1000.0;
    this_thread::sleep_for(chrono::milliseconds((long)max(1.0, real_ms)));
}

// ---------- Queue ops ----------
bool enqueue_packet(shared_ptr<Packet> p) {
    unique_lock<mutex> lk(q_mtx);
    if (schedule_mode == MODE_FCFS) {
        if ((int)fcfs_queue.size() >= B_cap) {
            total_dropped.fetch_add(1, memory_order_relaxed);
            dropped_per_src[p->src].fetch_add(1, memory_order_relaxed);

            // memory_order_seq_cst → fully synchronized (most strict, slowest)

            // memory_order_acquire

            // memory_order_release

            // memory_order_acq_rel

            // memory_order_relaxed → no synchronization, only atomicity


            return false;
        }
        p->enq_time = p->gen_time;
        fcfs_queue.push_back(p);
        q_cv.notify_one();
        return true;
    } else {
        if ((int)wfq_set.size() >= B_cap) {
            auto it = prev(wfq_set.end());
            if (it != wfq_set.end()) {
                double max_finish = it->first;
                if (max_finish > p->finish) {
                    auto victim = it->second;
                    wfq_set.erase(it);
                    total_dropped.fetch_add(1, memory_order_relaxed);
                    dropped_per_src[victim->src].fetch_add(1, memory_order_relaxed);
                    p->enq_time = p->gen_time;
                    wfq_set.insert({p->finish, p});
                    q_cv.notify_one();
                    return true;
                } else {
                    total_dropped.fetch_add(1, memory_order_relaxed);
                    dropped_per_src[p->src].fetch_add(1, memory_order_relaxed);
                    return false;
                }
            } else {
                total_dropped.fetch_add(1, memory_order_relaxed);
                dropped_per_src[p->src].fetch_add(1, memory_order_relaxed);
                return false;
            }
        } else {
            p->enq_time = p->gen_time;
            wfq_set.insert({p->finish, p});
            q_cv.notify_one();
            return true;
        }
    }
}

shared_ptr<Packet> dequeue_packet() {
    unique_lock<mutex> lk(q_mtx);
    while (!stop_all.load() && ((schedule_mode==MODE_FCFS && fcfs_queue.empty()) ||
                         (schedule_mode==MODE_WFQ && wfq_set.empty()))) {
        q_cv.wait_for(lk, chrono::milliseconds(10));
    }
    if (stop_all.load()) return nullptr;
    if (schedule_mode == MODE_FCFS) {
        auto p = fcfs_queue.front();
        fcfs_queue.pop_front();
        return p;
    } else {
        auto it = wfq_set.begin();
        if (it == wfq_set.end()) return nullptr;
        auto p = it->second;
        wfq_set.erase(it);
        return p;
    }
}

// ---------- Source thread ----------
void source_thread_fn(int src_idx, SourceCfg cfg) {
    double start_time = cfg.tb * T_sim;
    double end_time = cfg.te * T_sim;
    double t = start_time;
    sleep_sim(max(0.0, start_time));

    std::uniform_int_distribution<int> sizedist(cfg.Lmin, cfg.Lmax);
    while (true) {
        double ia = exp_rand(cfg.P);
        t += ia;
        if (t > end_time) break;

        auto p = make_shared<Packet>();
        p->id = ++global_packet_id;
        p->src = src_idx;
        p->size = sizedist(rng_engine);
        p->gen_time = t;

        if (schedule_mode == MODE_WFQ) {
            double my_weight = cfg.w;
            double prev = last_finish[src_idx];
            double finish_local = prev + ((double)p->size) / max(1e-9, my_weight);
            last_finish[src_idx] = finish_local;
            p->finish = finish_local;
        } else p->finish = 0.0;

        total_generated.fetch_add(1, memory_order_relaxed);
        generated_per_src[src_idx].fetch_add(1, memory_order_relaxed);
        enqueue_packet(p);
        sleep_sim(ia);
    }
}

// ---------- Scheduler thread ----------
void scheduler_thread_fn() {
    double sim_time = 0.0;
    auto sim_start = chrono::steady_clock::now();

    while (true) {
        auto now = chrono::steady_clock::now();
        double wall_elapsed = chrono::duration<double>(now - sim_start).count();
        sim_time = wall_elapsed / SIM_SPEEDUP;
        if (sim_time >= T_sim) {
            unique_lock<mutex> lk(q_mtx);
            bool empty = (schedule_mode==MODE_FCFS ? fcfs_queue.empty() : wfq_set.empty());
            if (empty) break;
        }
        auto p = dequeue_packet();
        if (!p) {
            if (sim_time >= T_sim) break;
            continue;
        }

        double tx_start = max(sim_time, p->enq_time);
        double tx_time = ((double)p->size) / C_bps;
        double wait_before = tx_start - sim_time;
        if (wait_before > 1e-12) sleep_sim(wait_before);
        p->tx_start_time = tx_start;
        sleep_sim(tx_time);
        p->tx_end_time = p->tx_start_time + tx_time;

        total_transmitted.fetch_add(1, memory_order_relaxed);
        transmitted_bytes.fetch_add(p->size, memory_order_relaxed);
        transmitted_bytes_per_src[p->src].fetch_add(p->size, memory_order_relaxed);
        {
            lock_guard<mutex> lg(stats_mtx);
            delays.push_back(p->tx_end_time - p->gen_time);
            transmitted_packets.push_back(p);
        }
        auto now2 = chrono::steady_clock::now();
        sim_time = chrono::duration<double>(now2 - sim_start).count() / SIM_SPEEDUP;
    }
    stop_all.store(true);
    q_cv.notify_all();
}

// ---------- Main ----------
int main(int argc, char** argv) {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    if (argc < 3) {
        cerr << "Usage: " << argv[0] << " input.txt MODE\nMODE = WFQ or FCFS\n";
        return 1;
    }
    string infile = argv[1];
    string mode = argv[2];
    if (mode == "WFQ") schedule_mode = MODE_WFQ;
    else if (mode == "FCFS") schedule_mode = MODE_FCFS;
    else { cerr << "Unknown MODE\n"; return 1; }

    ifstream fin(infile);
    if (!fin) { cerr << "Cannot open " << infile << "\n"; return 1; }

    string line;
    getline(fin, line);
    for (char &c: line) if (c=='=' || c==',') c=' ';
    stringstream ss(line);
    string k; double v;
    while (ss >> k >> v) {
        if (k == "N") N = (int)v;
        else if (k == "T") T_sim = v;
        else if (k == "C") C_bps = v;
        else if (k == "B") B_cap = (int)v;
    }

    sources.resize(N);
    last_finish.assign(N, 0.0);

    // ---- initialize atomics safely by constructing vectors of size N ----
    transmitted_bytes_per_src = vector<atomic<uint64_t>>(N);
    generated_per_src    = vector<atomic<uint64_t>>(N);
    dropped_per_src      = vector<atomic<uint64_t>>(N);

    for (int i=0;i<N;i++) {
        double Pi; int Lmin,Lmax; double wi,tbi,tei;
        fin >> Pi >> Lmin >> Lmax >> wi >> tbi >> tei;
        sources[i] = {Pi,(int)Lmin,(int)Lmax,wi,tbi,tei};
    }
    fin.close();

    vector<thread> src_threads;
    for (int i=0;i<N;i++) src_threads.emplace_back(source_thread_fn, i, sources[i]);
    thread sched(scheduler_thread_fn);
    for (auto &t: src_threads) t.join();
    {
        unique_lock<mutex> lk(q_mtx);
        q_cv.notify_all();
    }
    sched.join();

    // ---------- metrics ----------
    double util = ((double)transmitted_bytes.load()) / (C_bps * T_sim);
    vector<double> thr(N);
    for (int i=0;i<N;i++) thr[i] = (double)transmitted_bytes_per_src[i].load() / T_sim;
    double sum=0, sumsq=0;
    for (int i=0;i<N;i++) { sum += thr[i]; sumsq += thr[i]*thr[i]; }
    double fairness = (sumsq>0)? (sum*sum)/(N*sumsq):0;

    double avg_delay=0;
    {
        lock_guard<mutex> lg(stats_mtx);
        if (!delays.empty()) {
            double s=0;
            for (double d:delays) s+=d;
            avg_delay=s/delays.size();
        }
    }
    double drop_prob = (total_generated.load()>0)?
        (double)total_dropped.load()/total_generated.load() : 0;

    cout<<fixed<<setprecision(6);
    cout<<"Simulation results ("<<(schedule_mode==MODE_WFQ?"WFQ":"FCFS")<<")\n";
    cout<<"T="<<T_sim<<" s  C="<<C_bps<<" bytes/s  B="<<B_cap<<" pkts\n";
    cout<<"Generated="<< total_generated.load()
        <<", Transmitted="<< total_transmitted.load()
        <<", Dropped="<< total_dropped.load() <<"\n";
    cout<<"Utilization="<<util*100<<" %\n";
    cout<<"Jain Fairness Index="<<fairness<<"\n";
    cout<<"Average Packet Delay="<<avg_delay<<" s\n";
    cout<<"Drop Probability="<<drop_prob<<"\n\n";

    cout<<"Per-source stats:\n";
    for(int i=0;i<N;i++){
        cout<<"Src "<<i<<": gen="<<generated_per_src[i].load()
            <<", tx_bytes="<<transmitted_bytes_per_src[i].load()
            <<", dropped="<<dropped_per_src[i].load()<<"\n";
    }
    return 0;
}

