#include <bits/stdc++.h>
#include <vector>
#include <string>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#include <functional> // for less
using namespace std;
using namespace __gnu_pbds;


class polynomial
{
   private:
   int terms ;
   int * coeff ;
   int * degree;
      
   public:

   polynomial ( int x = 3 ) {
      terms = x;
      coeff = new int[terms];
      degree = new int[terms];
      for (int i = 0; i < terms; i++)
      {
         coeff[i] = 0; 
         degree[i] = 0;
      }   
   } 

   polynomial ( int * coeffval, int * degreeval , int termsval){
      terms = termsval;
      coeff = new int[terms];
      degree = new int[terms];
      for (int i = 0; i < terms; i++)
      {
         coeff[i] = coeffval[i]; 
         degree[i] = degreeval[i];
      }
   }

   // ~polynomial () {
   //    delete[] coeff;
   //    delete[] degree;
   // }

   friend istream& operator>>( istream& in , polynomial &p ){
      for (int i = 0; i < p.terms ; i++)
      {
         in >> p.coeff [i] >> p.degree[i] ;
      }
      return in;
   }
   friend ostream& operator<<( ostream& out , const polynomial& p ){
      for (int i = 0; i < p.terms ; i++)
      {
         out << p.coeff [i] <<" "<< p.degree[i] << endl;
      }
      return out;
   }

   polynomial operator+(const polynomial &p) const {
      polynomial q(terms);
      for (int i = 0; i < p.terms; i++)
      {
         q.coeff[i] = p.coeff[i] + (*this).coeff[i];
         q.degree[i] = p.degree[i];
      }
      return q;
   }
   polynomial operator- (const polynomial &p) const{
      polynomial q(terms);
      for (int i = 0; i < p.terms; i++)
      {
         q.coeff[i] = (*this).coeff[i] - p.coeff[i] ;
         q.degree[i] = p.degree[i];
      }
      return q;
   }
   polynomial operator* (const polynomial obj) const {
      polynomial q( terms + obj.terms - 1);
      for (int i = 0; i < terms + obj.terms - 1 ; i++)
      {
         q.degree[i] = terms + obj.terms - 2 - i;
      }
      
      for (int i = 0; i < terms; i++)
      {
         for (int j = 0; j < obj.terms; j++)
         {
            int sum = degree[i] + obj.degree[i];
            q.coeff[ terms + obj.terms -2 - sum ] += (coeff[i] * obj.coeff[j]);   
         } 
      }
      return q;
   }

};

class matrix
{
   private:
   int rows;
   int columns;
   polynomial ** m;

   public:

   matrix( int r = 2, int c = 2){
      rows = r; columns = c;
      m = new polynomial * [r];
      for (int i = 0; i < r; i++)
      {
         m[i] = new polynomial[c];
      }
   }
   ~matrix(){
      for (int i = 0; i < rows; i++)
      {
         delete[] m[i];
      }
      delete [] m ;
   }

   friend ostream& operator<<( ostream& out , const matrix& mat ){
      for (int i = 0; i < mat.rows; i++)
      {
         for (int j = 0; j < mat.columns; j++)
         {
            out << "( " << i << " , " << j << " )" << endl;
            out << (out, mat.m[i][j]);
            out << endl;
         } 
      }
      return out;      
   }
   // friend ostream& operator >> ( ostream& in , const matrix mat ){
   //    for (int i = 0; i < mat.rows; i++)
   //    {
   //       for (int j = 0; j < mat.columns; j++)
   //       {
   //          in >> mat.m[i][j];
   //       } 
   //    }
   //    return in;      
   // }

   polynomial * operator[] ( int num ) const{
      // cout<<num <<endl;
      if(num >=0 and num < rows){
         return m[num];
      }
      else{
         throw out_of_range("Matrix row index out of range.");
      }
   }

   matrix operator+ ( const matrix &mat ) const {
      matrix newm(mat.rows , mat.columns);
      for (int i = 0; i < mat.rows; i++)
      {
         for (int j = 0; j < mat.columns; j++)
         {
            newm.m[i][j] = mat.m[i][j] + (*this).m[i][j];
         }
      }
      return newm;
   }
   matrix operator- ( const matrix &mat ) const {
      matrix newm(mat.rows , mat.columns);
      for (int i = 0; i < mat.rows; i++)
      {
         for (int j = 0; j < mat.columns; j++)
         {
            newm.m[i][j] = (*this).m[i][j] -  mat.m[i][j] ;
         }
      }
      return newm;
   }

   matrix operator* (const matrix &mat) const {
      matrix newm(mat.rows , mat.columns);
      for (int i = 0; i < mat.rows; i++)
      {
         for (int j = 0; j < mat.columns; j++)
         {
            polynomial sum(5);
            for (int k = 0; k < mat.rows; k++)
            {
               sum =  sum + (this -> m[i][k] * mat.m[k][j]) ;
            }    
            newm.m[i][j] = sum;        
         }
      }     

      return newm;
   }

};




int main(){

   ifstream infile("week05-input-01 1.txt");
   int num, numterms ; 
   int rows , columns ;

   if(!infile.is_open()){
      cout << "error";
   }
   else{
      infile >> num >> numterms ;
      infile >> rows >> columns ;
      matrix m1(rows, columns);
      matrix m2(rows, columns);
      // matrix m1 [rows][columns] ;
      // cout << num << numterms << rows << columns << endl;

      for (int i = 0; i < rows; i++)
      {
         for (int j = 0; j < columns; j++)
         {
            polynomial p(numterms);
            infile >> p;

            // cout << p <<endl;

            m1[i][j] = p;
         }
         
      }

      for (int i = 0; i < rows; i++)
      {
         for (int j = 0; j < columns; j++)
         {
            polynomial p(numterms);
            infile >> p;

            m2[i][j] = p;
         }
         
      }
      infile.close();
      // cout<<m1<<endl<<endl;
      // cout<<m2<<endl<<endl;

      cout <<"sum ....................." <<endl;
      matrix add = m1+m2 ;
      cout << add;
      cout <<"minus ....................." <<endl;
      matrix minus = m1-m2 ;
      cout << minus;
      cout <<"multiply ....................." <<endl;
      matrix mul = m1*m2;
      cout<<mul;
      
   }

   return 0;
}