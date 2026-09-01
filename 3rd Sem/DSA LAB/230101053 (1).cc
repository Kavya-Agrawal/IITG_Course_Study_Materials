#include <bits/stdc++.h>
#include <fstream>
#include <vector>
#include <string>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#include <functional> // for less
using namespace std;
using namespace __gnu_pbds;


class matrix {


   int rows;
   int columns;
   float ** A ;
   public:

   matrix(int rowss = 10, int columnss =  10){
      rows = rowss;
      columns = columnss;
      A = new float*[rows];
      for (int i = 0; i < rows ; i++)
      {
         A[i] = new float [columns] ;
      }
      for (int i = 0; i < rows ; i++)
      {
         for (int j = 0; j < columns ; j++)
         {
            if(i == j) {A[i][j] = 1; continue;}
            A[i][j] = 0;
         }
      }
   }

   matrix(const float ** I , int rows, int columns){
      A = new float*[rows];
      for (int i = 0; i < rows ; i++)
      {
         A[i] = new float [columns] ;
      }
      for (int i = 0; i < rows ; i++)
      {
         for (int j = 0; j < columns ; j++)
         {
            A[i][j] = I[i][j];
         }
      } 
   }
   matrix( const char * filename){
      int rows1; int column1;
      ifstream inFile(filename);
      if(!inFile.is_open()){
         cout<<"Eroor 1" <<endl;
      }
      else{
         inFile >> rows1 >> column1 ;
         rows= rows1;
         columns = column1;
         A = new float*[rows1];
         for (int i = 0; i < rows1 ; i++)
         {
            A[i] = new float [column1] ;
         }
         for (int i = 0; i < rows1 ; i++)
         {
            for (int j = 0; j < column1 ; j++)
            {
               inFile >> A[i][j];
            }
         } 
         inFile.close();
      }

   }

   matrix( const matrix & m){
      rows = m.rows;
      columns = m.columns;


      A = new float*[rows];

      for (int i = 0; i < rows ; i++)
      {
         A[i] = new float [columns] ;
      }
      for (int i = 0; i < rows ; i++)
      {
         for (int j = 0; j < columns ; j++)
         {
            A[i][j] = m.A[i][j];
         }
      } 
   }

   matrix augment_matrix(){
      matrix m(rows ,  2*columns );
      matrix I(rows , columns);

      for (int i = 0; i < rows; i++)
      {
         for (int j = 0; j <  columns; j++)
         {
            m.A[i][j] = A[i][j];
         }
         for (int j = columns; j < 2* columns; j++)
         {
            m.A[i][j] = I.A[i][j - columns];
         } 
      }
      return m;
   }

   void forward_elimination(){
      for (int i = 0; i < columns / 2; i++)
      {
         int row_max = i;
         float maxi  = INT_MIN;
         for (int j = i; j < rows; j++)
         {
            if(abs(A[j][i] > maxi)){
               row_max = i;
               maxi = abs(A[j][i]);
            }
         }
         if(row_max != i){
            for (int j = 0; j < columns; j++)
            {
               float temp = A[i][j];
               A[i][j] = A[row_max][j];
               A[row_max][j] = temp;
            }
         }
         float factor = A[i][i];

         for (int j = 0; j < columns; j++)
         {
            A[i][j] /= factor;
         }
         
         for (int r = i+1 ; r < rows; r++)
         {
            float diff = A[r][i];
            for (int j = 0; j < columns; j++)
            {
               A[r][j] = A[r][j] - (diff) * A[i][j];
            }
         }
      }
   }
   void backward_elimination(){
      for (int i = columns/2 - 1; i >= 1; i--)
      {
         for (int j = i -1 ; j >= 0; j--)
         {
            float diff = A[j][i];
            for (int k = 0; k < columns; k++)
            {
               A[j][k] = A[j][k] - diff * A[i][k];
            }
         }  
      } 
   }

   matrix extract_inverse(){
      matrix Ainv (rows , columns/2) ;
      for (int i = 0; i < rows; i++)
      {
         for (int j = columns/2; j < columns; j++)
         {
            Ainv.A[i][j - columns/2] = A[i][j];
         }
         
      }
      return Ainv;
   }

   void print () {
      for (int i = 0; i < rows; i++)
      {
         for (int j = 0; j < columns; j++)
         {
            if(A[i][j] < 0.0000000000005 && A[i][j] > -0.000000000005) {
            cout <<fixed<< setprecision(2) <<  abs(A[i][j]) <<"  "; 
            continue;
            }
            cout <<fixed<< setprecision(2) <<  A[i][j] <<"  "; 
         }
         cout<<endl;
      } 
   }

   matrix multiply (matrix Ainv){
      matrix mynew(rows, columns);
      for (int i = 0; i < rows; i++)
      {
         for (int j = 0; j < columns; j++)
         {
            float sum = 0;
            for (int k = 0; k < columns ; k++)
            {
               sum+= (A[i][k] * Ainv.A[k][j]);
            }
            mynew.A [i][j] = sum;
         }
      }
      mynew.print();
      return mynew;
   }

   ~matrix(){
      for (int i = 0; i < rows; i++)
      {
         delete[] A [i];
      }
      delete A;
   }
};

int main(int argc, char *argv[]){

   matrix input_matrix ( argv[1]) ;
   cout<< endl;
   cout<<"IMPUT MATRIX ................................................" << endl;
   input_matrix.print();
   // input_matrix.print();
   matrix augmented_matrix = input_matrix.augment_matrix();


   augmented_matrix.forward_elimination();
   // augmented_matrix.print();
   augmented_matrix.backward_elimination();
   cout<< endl;
   cout<<"AUGMENTED MATRIX AFTER FORWARD AND BACKWARD ELIMINATION............." << endl;
   augmented_matrix.print();
   matrix inverse  = augmented_matrix.extract_inverse();
   cout<<"inverse matrix........................." << endl;
   inverse.print();

   cout<< endl;
   matrix aintoainv = input_matrix.multiply(inverse) ;


   // cout<< endl;
   //  matrix input_matrix2 ( argv[2]) ;
   // // input_matrix.print();
   //  augmented_matrix = input_matrix2.augment_matrix();
   // // augmented_matrix.print();


   // augmented_matrix.forward_elimination();
   // // augmented_matrix.print();
   // augmented_matrix.backward_elimination();
   // inverse  = augmented_matrix.extract_inverse();
   // inverse.print();

   // cout<< endl;
   //  aintoainv = input_matrix2.multiply(inverse) ;

   return 0;
}