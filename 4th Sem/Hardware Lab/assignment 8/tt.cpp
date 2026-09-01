#include <bits/stdc++.h>
#include <vector>
#include <string>
#include <tuple>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#include <functional> // for less
using namespace std;
using namespace __gnu_pbds;
void __print(int x) {cerr << x;}
void __print(long x) {cerr << x;}
void __print(long long x) {cerr << x;}
void __print(unsigned x) {cerr << x;}
void __print(unsigned long x) {cerr << x;}
void __print(unsigned long long x) {cerr << x;}
void __print(float x) {cerr << x;}
void __print(double x) {cerr << x;}
void __print(long double x) {cerr << x;}
void __print(char x) {cerr << '\'' << x << '\'';}
void __print(const char *x) {cerr << '\"' << x << '\"';}
void __print(const string &x) {cerr << '\"' << x << '\"';}
void __print(bool x) {cerr << (x ? "true" : "false");}

template<typename T, typename V>
void __print(const pair<T, V> &x) {cerr << '{'; __print(x.first); cerr << ','; __print(x.second); cerr << '}';}
template<typename T>
void __print(const T &x) {int f = 0; cerr << '{'; for (auto &i: x) cerr << (f++ ? "," : ""), __print(i); cerr << "}";}
void _print() {cerr << "]\n";}
template <typename T, typename... V>
void _print(T t, V... v) {__print(t); if (sizeof...(v)) cerr << ", "; _print(v...);}
#ifndef ONLINE_JUDGE
#define dg(x...) cerr << "[" << #x << "] = ["; _print(x)
#else
#define dg(x...)
#endif
typedef long long ll;
typedef unsigned long long ull;
typedef pair<ll, ll> pll;
typedef pair<int, int> pii;
typedef pair<int, ll> pil;
typedef pair<ll, int> pli;
typedef vector<ll> vl;
typedef vector<int> vi;
using t2 = array<ll, 2>;
using t3 = array<ll, 3>;
using t4 = array<ll, 4>;
#define p(g , h) pair<g , h> 
#define v(g) vector<g> 
const int MOD = 1e9 + 7;
const int INF = 1000000000;
#define all(v) v.begin(), v.end()
#define rall(v) v.rbegin(), v.rend()
template<class T> bool ckmax(T& a, const T& b) { return a < b ? a = b, 1 : 0;} 
template<class T> bool ckmin(T& a, const T& b) { return a > b ? a = b, 1 : 0;} 
#define ct cout << 
#define cten cout << endl;
#define ctiam cout << " It's_easier!!" << " \n " ;
#define ctafter  << " you_got_me!"  
#define ci cin >> 
#define blk  << " " << 
#define cty cout << "YES" << '\n';
#define ctn cout << "NO" << '\n';
#define en  << endl
#define endl '\n'
#define cin(a) for (auto &&var  : a) { ci var; }
#define cout(a) for (auto &&var  : a) { ct var << " "; } cten 
#define cinhf(a , n) for( ll i = 0 ; i < n ; i++ ) { ci a[i];} 
#define couthf(a , n) for( ll i = 0 ; i < n ; i++ ) { ct a[i] << " ";} cten 
#define cinhf2(a , n , m) for( ll i = 0 ; i < n ; i++ )  {for( ll j = 0; j < m; j++ ) { ci a[i][j];} } 
#define couthf2(a , n , m) for( ll i = 0 ; i < n ; i++ )  {for( ll j = 0; j < m; j++ ) { ct a[i][j] << " ";} cten } cten 
#define cin2(a) for( auto &&var1 : a)  for( auto &&var2 : var1)  ci var2; 
#define cout2(a) for( auto &&var1 : a)  {for( auto &&var2 : var1)  {ct var2 << " ";} cten } cten 
typedef tree<int, null_type, less<int>, rb_tree_tag, 
 tree_order_statistics_node_update> ordered_set;

int log2_floor(unsigned long long i) {
    #if defined(__cpp_lib_bitops) && __cpp_lib_bitops >= 201907L // Use std::bit_width if available (C++20)
        return std::bit_width(i) - 1;
    #else
        return __builtin_clzll(1) - __builtin_clzll(i);
    #endif
}

ll sumtilln (ll n){
    return (((n)*(n+1)) / 2) ;
}
int modular_exponent(long long x, unsigned int y, int p) { 
    int res = 1; 
    x = x % p;  
    if (x == 0) return 0; 
    while (y > 0) { 
        if (y & 1) res = (res*x) % p;  
        y = y>>1; 
        x = (x*x) % p; 
    } 
    return res;
}
ll mypowmod(ll a, ll b, ll mod){
   ll ans = 1ll;
   for( int i = 1; i <= b; i++ ){ ans = ((ans % mod)*((ll)a  % mod))  % mod ;}
   return ans  % mod;
}
ll mypow(ll a, ll b){
   ll ans = 1ll;
   for( int i = 1; i <= b; i++ ){ ans = ((ans)*((ll)a)) ;}
   return ans;
}

ll digitlength( ll n , ll b ){
    if(b == 2) return floorl ( (long double) log2l(( long double) n)) + 1 ;
    if(b == 10) return floorl ( (long double) log10l(( long double) n)) + 1 ;
} 

//#define int ll


void solve(){

    ll n,m;
        cin >> n >> m;
        vector<ll> a(n);
        inv(a);
        vector<ll> b(m);
        inv(b);
        vector<vector<vector<ll>>> dp(n+1,vector<vector<ll>>(m+1,vector<ll>(2,1e10)));
        // dp[i][j][1] = min k value to pick flowers from i and jth indices if 1 magic left
        // dp[i][j][0] = min k value to pick flowers from i and jth indices if 1 magic not left
        dp[n][m-1][1] = b[m-1];
        for(ll i=0;i<=n;i++) {
            dp[i][m][0] = 0;
            dp[i][m][1] = 1e10;
        }
        for(ll i=n-1;i>=0;i--){
            for(ll j=m-1;j>=0;j--){
                if(a[i]>=b[j]){
                    dp[i][j][0] = dp[i+1][j+1][0];
                    if(dp[i+1][j+1][1]==1e10){
                        if(dp[i][j+1][0]==1e10){
                            dp[i][j][1] = 1e10;
                        }
                        else dp[i][j][1] = b[j];
                        continue;
                    }
                    if(dp[i][j+1][0]==1e10){
                        dp[i][j][1] = dp[i+1][j+1][1];
                    }
                }
                else{
                    dp[i][j][0] = dp[i+1][j][0];
                    if(dp[i][j+1][0]==1e10){
                        dp[i][j][1] = dp[i+1][j][1];
                        continue;
                    }
                    if(dp[i+1][j][1]==1e10){
                        dp[i][j][1] = b[j];
                        continue;
                    }
                    dp[i][j][1] = min(dp[i][j+1][0],dp[i+1][j][1]);
                }
            }
        }
        if(dp[0][0][1]==1e10) cout << -1 << endl;
        else cout << dp[0][0][1] << endl;

}

signed main(){

    ios_base::sync_with_stdio(false);
    cin.tie(NULL);cout.tie(NULL);

    int t;
    cin>> t;
    //t=1;
    //tsieve(); // to calculate the prime factorisation O(n.loglogn)
    //tsieve(); // to calculate the ncr and factorials in O(logn) and O(1)
    while(t--){
        solve();
    }
    
    return 0;
}