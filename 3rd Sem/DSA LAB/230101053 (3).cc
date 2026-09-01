#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#include <functional> // for less
using namespace std;
using namespace __gnu_pbds;

class Ratio
{
   private:
      int numer;
      int denom;
      
   public:

      Ratio(int num = 0, int den = 1){
         numer = num;
         denom = den;
      }

      Ratio( const Ratio & r ){
         numer = r.numer;
         denom = r.denom;
      }

      bool operator < (const Ratio & r){
         return (numer * r.denom < denom * r.numer);
      }

      friend istream& operator>>(istream &in , Ratio & r){
         in >> r.numer >> r.denom;
         // in >> r.denom;
         return in;
      }
      friend ostream& operator<<(ostream & out, const Ratio r){
         out << r.numer <<"/";
         out << r.denom;
         return out;
      }

      Ratio * operator [](int x) {
         return this;
      }
};

template <typename T>
class Sort
{
private:
   int num;
   T * data ;

public:
   Sort(int n = 10){
      num = n;
      data = new T[n];
   }
   Sort(const T ** d, int n){
      // d = (const T *) dd;
      num = n;
      data = new T[n];
      for( int i = 0; i < n; i++ ){ data[i] = (*d)[i] ;}
   }
   Sort( const T* p ){
      data = new T[num];
      for( int i = 0; i < num; i++ ){ data[i] = p[i] ;}
   }
   void insertion_sort( bool b = 1) const {
      
      if(b == 1){
      for (int i = 0; i < num; i++)
      {
         int  j = i-1;
         while (j >= 0 and !(data[j] < data[j+1]))
         {
            T temp = data[j];
            data[j] = data[j+1];
            data[j+1] = temp;
            j--;
         }       
      }}
      if( b == 0 ){
         for (int i = 0; i < num; i++)
         {
            int  j = i-1;
            while (j >= 0 and (data[j] < data[j+1]))
            {
               T temp = data[j];
               data[j] = data[j+1];
               data[j+1] = temp;
               j--;
            }       
         }
      }
      

   }
   T tmin(const T a, const T b){
      if (a>b)
      {
         return a;
      }
      else
      {
         return b;
      }
   }
   friend istream& operator>>( istream & in , Sort<T> &r){
      // cout << r.num << endl;
      for( int i = 0; i < r.num; i++ ){ 
         in >> r.data[i];
      }
      return in;
   }
   friend ostream& operator<<( ostream & out , Sort<T> &r ){
      for( int i = 0; i < r.num; i++ ){ 
         out << r.data[i] <<" ";
      }
      out << endl;
      return out;
   }
   ~Sort(){
      delete[] data;
   }
   
};

int main(){

   Ratio r(2, 5);
   // Ratio rr;

   
   // string s ;
   // cin >> s;

   ifstream inFile("int-sort 1.txt");
   if(!inFile.is_open()){
      cout<<"Errrror";
   }
   else{
      int num;
      
      inFile >> num;
      // int * arr = new int[num];
      // for (int i = 0; i < num; i++)
      // {
      //    inFile >> arr[i];
      // }

      Sort<int> ss (num);
      inFile >> ss;
      // cout << ss << endl;

      cout<<" Decending.............................."<<endl<<endl;
      ss.insertion_sort(0);
      cout << ss << endl;
      cout<<" Ascending.............................."<<endl<<endl;
      ss.insertion_sort(1);
      cout << ss << endl;

      cout << endl<<endl;
      inFile.close();
   }
   ifstream inFile2("float-sort.txt");
   if(!inFile2.is_open()){
      cout<<"Errrror";
   }
   else{
      int num;
      
      inFile2 >> num;
      // float * arr = new float[num];
      // for (int i = 0; i < num; i++)
      // {
      //    inFile2 >> arr[i];
      // }

      // Sort<float> ss (arr, num);
      Sort<float> ss (num);
      inFile2 >> ss;
      // cout << ss << endl;

      cout<<" Decending.............................."<<endl<<endl;
      ss.insertion_sort(0);
      cout << ss << endl;
      cout<<" Ascending.............................."<<endl<<endl;
      ss.insertion_sort(1);
      cout << ss << endl;
      cout << endl<<endl;

      inFile2.close();
   }
   ifstream inFile3("char-sort.txt");
   if(!inFile3.is_open()){
      cout<<"Errrror";
   }
   else{
      int num;
      
      inFile3 >> num;
      // char * arr = new char[num];
      // for (int i = 0; i < num; i++)
      // {
      //    inFile3 >> arr[i];
      // }

      // Sort<char> ss (arr, num);
      Sort<char> ss (num);
      inFile3 >> ss;
      // cout << ss << endl;

      cout<<" Decending.............................."<<endl<<endl;
      ss.insertion_sort(0);
      cout << ss << endl;
      cout<<" Ascending.............................."<<endl<<endl;
      ss.insertion_sort(1);
      cout << ss << endl;
      cout << endl<<endl;

      inFile3.close();
   }
   ifstream inFile4("string-sort.txt");
   if(!inFile4.is_open()){
      cout<<"Errrror";
   }
   else{
      int num;
      
      inFile4 >> num;
      // string * arr = new string[num];
      // for (int i = 0; i < num; i++)
      // {
      //    inFile4 >> arr[i];
      // }

      // Sort<string> ss (num);
      Sort<string> ss (num);
      inFile4 >> ss;
      // cout << ss << endl;

      cout<<" Decending.............................."<<endl<<endl;
      ss.insertion_sort(0);
      cout << ss << endl;
      cout<<" Ascending.............................."<<endl<<endl;
      ss.insertion_sort(1);
      cout << ss << endl;
      cout << endl<<endl;

      inFile4.close();
   }
   ifstream inFile5("ratio-sort.txt");
   if(!inFile5.is_open()){
      cout<<"Errrror";
   }
   else{
      int num;
      
      inFile5 >> num;
      // Ratio * arr = new Ratio[num];
      // for (int i = 0; i < num; i++)
      // {
      //    inFile5 >> arr[i];
      // }

      // Sort<Ratio> ss (arr, num);
            Sort<Ratio> ss (num);
      inFile5 >> ss;
      // cout << ss << endl;

      cout<<" Decending.............................."<<endl<<endl;

      ss.insertion_sort(0);
      cout << ss << endl;
      cout<<" Ascending.............................."<<endl<<endl;
      ss.insertion_sort(1);
      cout << ss << endl;
      cout << endl<<endl;

      inFile5.close();
   }


   return 0;
}