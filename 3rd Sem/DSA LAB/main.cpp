

#include <bits/stdc++.h>
#include "graph.h"
// #include <vector>
// #include <string>
// #include <ext/pb_ds/assoc_container.hpp>
// #include <ext/pb_ds/tree_policy.hpp>
// #include <functional> // for less

using namespace std;
using namespace cs204_graph;

int main(){


   ios_base::sync_with_stdio(false);
   cin.tie(NULL);cout.tie(NULL);

   int ver = 0 ;
   string s;
   ifstream infile10("am-10x10.txt");
   while ( getline(infile10 , s) )
   {
      ver++;
   }
   infile10.close();
   cout<<endl;
   cout<<"no of verties in 10x10 is "<< ver << endl;
   cout<<endl;
   

   graph g(ver) ;
   g.adjancency_matrix("am-10x10.txt");
   cout<<endl;
   g.adjacencylist("al-10x10.txt");
   cout<<endl;
   cout<<endl;
   cout<<"dfs using first matrices and then list for 10x10: "<<endl;
   cout<<endl;
   g.dfs_matrix();
   cout<<endl;
   g.dfs_list();
   cout<<endl;
   cout<<endl;
      cout<<endl;
   cout<<"bfs using first matrices and then list for 10x10: "<<endl;
   cout<<endl;

   g.bfs_matrix();
   cout<<endl;
   g.bfs_list();
   cout<<endl;
   cout<<endl;


   ver = 0 ;
   // string s;
   ifstream infile20("am-20x20.txt");
   while ( getline(infile20 , s) )
   {
      ver++;
   }
   infile20.close();
   cout<<endl;
   cout<<"no of verties in 10x10 is "<< ver << endl;
   cout<<endl;

   graph gs(20) ;
   gs.adjancency_matrix("am-20x20.txt");
   cout<<endl;
   gs.adjacencylist("al-20x20.txt");
   cout<<endl;
   cout<<endl;
   cout<<"dfs using first matrices and then list for 20x20: "<<endl;
   cout<<endl;
   gs.dfs_matrix();
   cout<<endl;
   gs.dfs_list();
   cout<<endl;
   cout<<endl;
   cout<<"bfs using first matrices and then list for 20x20: "<<endl;
   cout<<endl;

   gs.bfs_matrix();
   cout<<endl;
   gs.bfs_list();

   

   return 0;
}