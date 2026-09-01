namespace cs204_graph
{
   class graph
   {
   private:
      int n;
      int ** adjm;
      int ** adjl;      
   public:
      graph (int num);
      void adjancency_matrix(char * ptr);
      void adjacencylist(char * ptr); 
      void dfs_matrix();
      void dfs_helper( int u ,  int * &vis );
      void dfs_list();
      void dfs_helper_for_lsit ( int u ,  int* &vis );
      void bfs_matrix();
      void bfs_list();
      ~graph();
   };
   
} // namespace cs204_graph
