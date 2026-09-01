#include <bits/stdc++.h>
#include  <utility>
#include <vector>
#include <string>
using namespace std;
typedef long long ll;



class matrix
{
protected:
   int rows;
   int columns;
   float ** a;
public:
   
   matrix( int r= 4, int c = 4){
      rows = r;
      columns = c;
      a = new float*[rows];
      for( int j = 0; j < rows; j++ ){ 
         a[j]  = new float[columns];
      }
   }

   matrix(const float** aa, int r, int c ){
      rows = r;
      columns = c;
      for( int i = 0; i < rows; i++ ){    
         for( int j = 0; j < columns; j++ ){ 
            a[i][j]  = aa[i][j];
         }
      }
   }

   matrix( const matrix & m){
      rows = m.rows;
      columns = m.columns;
      a = new float*[rows];
      for( int j = 0; j < rows; j++ ){ 
         a[j]  = new float[columns];
      }

      for( int i = 0; i < rows; i++ ){    
         for( int j = 0; j < columns; j++ ){ 
            a[i][j]  = m.a[i][j];
         }
      }
   }

   pair< matrix, matrix> lu_decomposition() const {

      matrix L(rows, columns);
      matrix U(rows, columns);

      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){ 
            if(i == j) {L.a[i][j] = 1; U.a[i][j] = 0;}
            else{
               L.a[i][j] =0; U.a[i][j] = 0;
            }
         }
      }

      for( int i = 0; i < rows; i++ ){  

         for( int k = i; k < columns; k++ ){ 

            float val = 0;
            for( int j = 0 ; j <= i-1; j++ ){  
               val += L.a[i][j] * U.a[j][k];
            }
            U.a[i][k] = a[i][k] - val;

         }
         for( int k = i+1; k < rows; k++ ){ 

            if(U.a[i][i] == 0) {
               cout << "the matrix is singular" << endl; 
               return make_pair(L, U);
            }
            else{
               float val = 0;
               for( int j = 0 ; j <= i-1; j++ ){  
                  val += L.a[k][j] * U.a[j][i];
               }
               L.a[k][i] = (a[k][i] - val) / U.a[i][i];
            }
         }
      }

      return make_pair(L, U);
   }

   float determinant( const matrix & L , const matrix& U ){
      float l = 1;
      float u = 1;
      float det = 1;
      // for( int i = 0; i < rows; i++ ){ 
      //    for( int j = 0; j < columns; j++ ){    
      //       if(i == j) l *= L.a[i][j];
      //    }
      // }
      // for( int i = 0; i < rows; i++ ){ 
      //    for( int j = 0; j < columns; j++ ){    
      //       if(i == j) u *= U.a[i][j];
      //    }
      // }
      for( int i = 0; i < L.rows; i++ ){ 
         // cout<< L.a[i][i] << endl;
         det *= L.a[i][i];
      }
      for( int i = 0; i < U.rows; i++ ){ 
         // cout<< U.a[i][i] << endl;
         det *= U.a[i][i];
      }

      // return l * u;
      return det;

   } 

   friend istream& operator >> ( istream & in , const matrix& m ) {
      for( int i = 0; i < m.rows  ; i++ ){
         for( int j = 0; j < m.columns; j++ ){ 
            in >> m.a[i][j];
         }
      }
      return in;
   }

   friend ostream& operator << ( ostream& out , const matrix& m ) {
      for( int i = 0; i < m.rows  ; i++ ){
         for( int j = 0; j < m.columns; j++ ){ 
            out << fixed << setprecision(2) <<m.a[i][j] << " ";
         }
         cout << endl;
      }
      return out;
   }
   
   ~ matrix (){
      for( int i = 0; i < rows; i++ ){ 
         delete [] a[i];
      }
      delete [] a;
   }

   matrix operator * ( const matrix& m ) const {
      matrix ans(rows , columns);
      for( int i = 0; i < rows; i++ ){    
         for( int j = 0; j < columns; j++ ){ 
            float sum = 0;
            for( int k = 0; k < rows; k++ ){    
               sum += a[i][k] * m.a[k][j];
            }
            ans.a[i][j] = sum;
         }
      }

      return ans;
   }

   matrix operator - ( const matrix & m ){
      matrix ans( rows, columns);

      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){ 
            ans.a[i][j] = a[i][j] - m.a[i][j];
         }
      }

      return ans;
   }

   int get_rows (){
      return rows;
   }
   int get_col (){
      return columns;
   }
   float ** geta (){
      return a;
   }

};

class identity_matrix  : public matrix
{
private:
public:
   // using matrix::matrix;
   // int r = get_rows();
   // int c = get_col();
   
   // using matrix::matrix;
   // matrix iden(r , c);


   identity_matrix( int r = 4, int c = 4) : matrix(r , c) {
      rows = r;
      columns = c;
      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){    
            if(i == j)   a[i][j]= 1;
            else a[i][j] = 0;
         }
      }
   }
   identity_matrix( matrix & m){
      a = new float * [rows];
      for( int i = 0; i < rows; i++ ){ 
         a[i] = new float [columns];
      }

      float ** ptr = m.geta();

      for( int i = 0; i < rows; i++ ){    
         for( int j = 0; j < columns; j++ ){ 
            a[i][j] = ptr[i][j];
         }
      }


   }
   friend istream& operator >> ( istream & in , const identity_matrix& m ) {
      for( int i = 0; i < m.rows  ; i++ ){
         for( int j = 0; j < m.columns; j++ ){ 
            in >> m.a[i][j];
         }
      }
      return in;
   }
   
// singular
   float determinant(){
      float ans = 1;
      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){    
            if(i == j) ans *= a[i][j];
         }
      }
      return ans;
   }
   
};

class diagonal_matrix : protected identity_matrix
{
private:
public:
   diagonal_matrix( int r= 4, int c = 4){
      rows = r;
      columns= c;
      a = new float*[rows];
      for( int j = 0; j < rows; j++ ){ 
         a[j]  = new float[columns];
      }
      for( int i = 0; i < rows; i++ ){    
         for( int j = 0; j < columns; j++ ){ 
            if( i == j) a[i][j]  = 10;
            else a[i][j] = 0;
         }
      }
   }
   diagonal_matrix( identity_matrix & m){
      rows = m.get_rows();
      columns = m.get_col();
      float ** ptr = m.geta();

      bool isdiag = 1;
      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){    
            if(i != j and ptr[i][j] != 0){
               isdiag  = 0; break;
            }
         }
      }

      if(isdiag == 0){
         cout << "not diagonal";
      }
      else{
         a = new float*[rows];
         for( int j = 0; j < rows; j++ ){ 
            a[j]  = new float[columns];
         }

         for( int i = 0; i < rows; i++ ){    
            for( int j = 0; j < columns; j++ ){ 
               a[i][j]  = ptr[i][j];
            }
         }
      }


   }

   float determinant(){
      float ans = 1;
      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){    
            if(i == j) ans *= a[i][j];
         }
      }
      return ans;
   }
   friend istream& operator >> ( istream & in , const diagonal_matrix& m ) {
      for( int i = 0; i < m.rows  ; i++ ){
         for( int j = 0; j < m.columns; j++ ){ 
            in >> m.a[i][j];
         }
      }
      return in;
   }

   void print ( diagonal_matrix d){
      pair<matrix, matrix> q = d.lu_decomposition();
      // cout<< endl << q.first << endl << q.second << endl;

      cout << d.determinant( ) << endl;

      cout<< d - ( q.first * q.second) << endl << endl;
   }
   
};

class triangular : private matrix
{
private:
public:

   triangular ( int r= 4,  int c = 4){
      rows = r;
      columns= c;
      a = new float*[rows];
      for( int j = 0; j < rows; j++ ){ 
         a[j]  = new float[columns];
      }
      for( int i = 0; i < rows; i++ ){    
         for( int j = 0; j < columns; j++ ){ 
            if( i == j) a[i][j]  = 10;
            else a[i][j] = 0;
         }
      }
   }
   triangular( matrix & m){
      bool isupper  = 0;
      bool islower  = 0;

      rows = m.get_rows();
      columns = m.get_col();
      float ** ptr = m.geta();

      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){    
            if(i > j ){
               if(ptr[i][j] != 0){
                  isupper = 0;
                  break;
               }
            }
         }
      }
      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){    
            if(i < j ){
               if(ptr[i][j] != 0){
                  islower = 0;
                  break;
               }
            }
         }
      }


      if(isupper == 1 or islower == 1){
         a = new float*[rows];
         for( int j = 0; j < rows; j++ ){ 
            a[j]  = new float[columns];
         }

         for( int i = 0; i < rows; i++ ){    
            for( int j = 0; j < columns; j++ ){ 
               a[i][j]  = ptr[i][j];
            }
         }
      }
      else{
         cout << "not triangluar";
      }


   }
   friend istream& operator >> ( istream & in , const triangular& m ) {
      for( int i = 0; i < m.rows  ; i++ ){
         for( int j = 0; j < m.columns; j++ ){ 
            in >> m.a[i][j];
         }
      }
      return in;
   }

   float determinant(){
      float ans = 1;
      for( int i = 0; i < rows; i++ ){ 
         for( int j = 0; j < columns; j++ ){    
            if(i == j) ans *= a[i][j];
         }
      }
      return ans;
   }

   void print ( triangular t){
      pair<matrix, matrix> q = t.lu_decomposition();
      // cout<< endl << q.first << endl << q.second << endl;

      cout << t.determinant( ) << endl;

      cout<< t - ( q.first * q.second) << endl << endl;
   }
   
};



int main(){

   // ifstream inFile("week06-input-01.txt");
   // if (!inFile.is_open())
   // {
   //    cout << "Error occured !" ;
   // }
   // else
   // {
      int rows;
      int columns;
      cin >> rows >> columns; 
      // cout << rows << columns << endl;
      matrix A(rows , columns);
      cin >> A;  
      cout << A;
      // matrix L(rows , columns), U(rows , columns);

      pair<matrix, matrix> p = A.lu_decomposition();
      // cout<< endl << p.first << endl << p.second << endl;

      cout << A.determinant( p.first , p.second ) << endl;

      cout<< A - ( p.first * p.second) << endl << endl;
   
      identity_matrix I(rows, columns);
            cin >> I;
      pair<matrix, matrix> q = I.lu_decomposition();
      // cout<< endl << q.first << endl << q.second << endl;

      // cin >> D;
      cout << I.determinant( ) << endl;

      cout<< I - ( q.first * q.second) << endl << endl;
      // pair<matrix, matrix> q = D.lu_decomposition();
      // // cout<< endl << q.first << endl << q.second << endl;

      // cout << D.determinant( ) << endl;

      // cout<< D - ( q.first * q.second) << endl << endl;

      diagonal_matrix D(rows , columns );
      cin >> D;
      D.print( D );
      triangular T(rows , columns );
      cin >> T;
      T.print( T );

   //////////////////////////////////////////////////////////these will work for differnt file inpputs for I, D , T;



   return 0;
}