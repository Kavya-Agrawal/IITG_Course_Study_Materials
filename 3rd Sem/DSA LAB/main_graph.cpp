
#include <bits/stdc++.h>
#include "graph.h"
// #include <vector>
// #include <string>
// #include <ext/pb_ds/assoc_container.hpp>
// #include <ext/pb_ds/tree_policy.hpp>
// #include <functional> // for less

using namespace std;
using namespace cs204_graph;
// using namespave 

// /// makking own non cylcic queue //////////////
// class myqueue
// {
// private:
//    int f = 0;
//    int e = 0;
//    int sz = 0;
//    int cap ;
//    int * data;
// public:
//    myqueue( int c ){
//       cap = c;
//       data= new int[c];
//    }
//    void enqueue( int a ){
//       data[e] = a;
//       e++;
//       sz++;
//    }
//    int dequeue(){
//       if(sz==0) {
//          cout<<"emptyyy"<< endl;
//       }
//       else {
//          int temp = data[f];
//          f++;
//          sz --;
//          return temp;
//       }
//    }
//    bool isempty(){
//       return (sz==0);
//    }
   
// };

template< typename T>
class queuee
{
private:
   
   int front ;
   int rear;
   int capacity;
   int size;
   T * data;

public:

   queuee(int c){
      front = 0;
      rear = -1;
      capacity = c;
      size = 0;
      data = new T[c];
   }

   ~queuee(){
      delete[] data;
   }

   void enque( const T & a){
      // cout<< rear << capacity<<endl;
      if (rear == capacity - 1) {
            cout <<endl << "Queue is full" << endl;
            return;
      }
      size++;
      data[++rear] = a;
      return;
   }

   T dequeue()
   {
      if (front > rear) {
         cout <<endl << "Queue is enpty" << endl;
         T temp;
         return temp;
      }
      T temp = data[0];
      for (int i = 0; i < rear; i++) {
         data[i] = data[i + 1];
      }
      size--;
      rear--;
      return temp;
   }

   T & getFront()
   {
      if (rear == -1) {
         cout <<endl << "Queue is enpty" << endl;
         // T temp;
         // return temp;
         __throw_out_of_range("emptyyyyyyyyyyyyyy");
      }
      return data[front];
   }

   bool isempty(){
      if(rear==-1)
      {return true;}
      else return false;
   }

   int getsize(){
      return size;
   }
   
};


graph::graph (int num){
   n = num;
   adjm = new int * [n];
   for (int i = 0; i < n; i++)
   {
      adjm[i] = new int [n];
   }
   for( int i = 0; i < n; i++ ){ 
      for( int j = 0; j < n; j++ ){    
         adjm[i][j] = 0;
      }
   }
   adjl = new int * [n];
   for (int i = 0; i < n; i++)
   {
      adjl[i] = NULL;
   } 
}

void graph::adjancency_matrix(char * ptr){
   ifstream inFile(ptr);
   int no_edges = 0;
   if(!inFile.is_open()){
      cout<< " erroree " ;
   }
   else{
      for( int i = 0; i < n; i++ ){ 
         for( int j = 0; j < n; j++ ){    
            inFile >> adjm[i][j];
            if(adjm[i][j] == 1 && j != i) no_edges++;
         }
      }
      // for (int i = 0; i < n; i++)
      // {
      //    for( int j = 0; j < n; j++ ){ 
      //       cout<<adjm[i][j]<<" ";

      //    }
      //    cout<<endl;
      // }
      cout<<"no of edges is using matrix " << no_edges / 2 <<endl;
      cout<<endl;
      
      inFile.close();
   }
}

void graph::adjacencylist(char * ptr){
   int no_edges = 0;
   ifstream inFile(ptr);
   if(!inFile.is_open()){
      cout<< " erroree " ;
   }
   else{
      // int count = 0;
      int u , len = 0;
      // inFile >> u;
      int temp[10000];
      for (int k = 0; k < n; k++)
      {
         len = 0; u = 0;
         while (u != -1)
         {
            inFile  >> u;
            temp[len] =  u;
            len ++;
            // if(u == -)
            no_edges++;
            // i++;
         }
         adjl[k] = new int [len];
         for (int j = 0; j < len; j++)
         {
            adjl[k][j] = temp[j];
         }
      }
      // for (int i = 0; i < n; i++)
      // {
      //    int j = 0;
      //    while (adjl[i][j] != -1)
      //    {
      //       cout<<adjl[i][j]<<" ";
      //       j++;
      //    }
      //    cout<<adjl[i][j]<<endl;;
                  
      // }
      
      cout<<"no of edges is using list is " << ( no_edges) / 2  - n <<endl;
      cout<<endl;
      
      inFile.close();
   }
}

void graph::dfs_matrix(){
   // int vis[n] = {0};
   int * vis = new int [n];
   for (int i = 0; i < n; i++)
   {
      vis[i] = 0;
   }
   for (int i = 0; i < n; i++)
   {
      if(vis[i] == 0)    dfs_helper(i , vis);  
   }
   
 

   // stackk<int> s(10000);
   // s.push(0);
   // while (!s.empty())
   // {
   //    int u = s.top();
   //    for (int i = 0; i < n ; i++)
   //    {
   //       if(adjm[u][i])
   //    }
   // }
   
}
/////////   TOLD BY THE TA THAT CREATING SUCH A HELPER FUNCTION IS VALID!  //////////

void graph::dfs_helper( int u ,  int* &vis ){
   vis[u] = 1;
   cout<< u <<" ";
   // cout<<n<<endl;
   for (int i = 0; i < n; i++)
   {
      if( adjm[u][i] == 0 ) continue;
      // cout<<  "i" << i <<"i"; 
      // cout <<  i <<" "<< adjm[u][i] << endl;
      if(vis[i]) continue;;
      graph::dfs_helper( i , vis);
   }
}

void graph::dfs_list(){
   int * vis = new int [n];
   for (int i = 0; i < n; i++)
   {
      vis[i] = 0;
   }
   for (int i = 0; i < n; i++)
   {
      if(vis[i] == 0) dfs_helper_for_lsit(i , vis);  
   }
}

void graph::dfs_helper_for_lsit ( int u ,  int* &vis ){
   vis[u] = 1;
   cout<< u <<" ";
   // cout<<n<<endl;
   int p = 0;
   while( adjl[u][p] != -1)
   {
      if(vis[adjl[u][p]]) {p++; continue;}
      graph::dfs_helper( adjl[u][p] , vis);
      p++;
   }
}

void graph::bfs_matrix(){
   int * vis = new int [n];
   for (int i = 0; i < n; i++)
   {
      vis[i] = 0;
   }
   queuee<int> q(1000000);
   q.enque(0);
   vis[0] = 1;
   cout<<0 <<" ";
   while (!q.isempty())
   {
      int t = q.dequeue();
      for( int i = 0; i < n; i++ ){ 
         if(adjm[t][i] && !vis[i]){
            q.enque(i);
            vis[i] = 1;
            cout<<i <<" ";
         }
      }
   }
   
}
void graph::bfs_list(){
   int * vis = new int [n];
   for (int i = 0; i < n; i++)
   {
      vis[i] = 0;
   }
   queuee<int> q(1000000);
   q.enque(0);
   vis[0] = 1;
   cout<<0 <<" ";
   while (!q.isempty())
   {
      int t = q.dequeue();
      int j  = 0;
      while(adjl[t][j] != -1){ 
         if(!vis[adjl[t][j]]){
            q.enque(adjl[t][j]);
            vis[adjl[t][j]] = 1;
            cout<<adjl[t][j] <<" ";
            j++;
         }
         else{j++;}
      }
   }
}

graph::~graph(){
   for (int i = 0; i < n; i++)
   {
      delete[] adjm[i];
      delete[] adjl[i];
   }
   delete [] adjm;
   delete [] adjl;
}

