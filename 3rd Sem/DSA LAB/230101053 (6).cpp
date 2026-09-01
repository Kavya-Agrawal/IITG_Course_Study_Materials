#include <bits/stdc++.h>
#include <vector>
#include <string>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#include <functional> // for less
using namespace std;
using namespace __gnu_pbds;
const int maxsize = 10000;

class Errors {
private:
   string errors;
public:
   Errors(const string& message) : errors(message) {}
   string showError() const {
      return errors;
   }
};

template<typename T>
class Radix
{
private:
   T * arr;
   int size = 0;
   int base;
   
public:
   Radix(T * a, int siz,  int bas){
      if(siz > maxsize){
         throw Errors("Max memeory exceeded........................");
      }
      if(base <= 0){
         throw Errors("Base not allowed........................");
      }
      size = siz;
      arr = new T[size];
      base = bas;
      for (int i = 0; i < size; i++)
      {
         arr[i] = a[i];
      }
   }
   ~Radix(){
      delete [] arr;
   }  

   void counting_sort(int digitPos) {
      T output[size];
      int count[base+1] = {0};
      int basepow = 1;
      for (int i = 0; i < digitPos; i++)
      {
         basepow *= base;
      }

      for (int i = 0; i < size; ++i) {
         int digit = (arr[i] / basepow ) % base;
         count[digit]++;
      }

      for (int i = 1; i < base; ++i) {
         count[i] += count[i - 1];
      }

      for (int i = size - 1; i >= 0; --i) {
         int digit = (arr[i] / basepow) % base;
         output[count[digit] - 1] = arr[i];
         count[digit]--;
      }
      for( int i = 0; i < size; i++ ){ 
         arr[i] = output[i];
      }
   }

   void radix_sort() {
      T maxElement = getmax();
      int i = 0 ;
      for (int digitPos = 1; maxElement / digitPos > 0; digitPos *= base) {
         counting_sort(i);
         i++;
      }
   }

   void print()  {
      if(base == 16)
      {
         for (int i = 0; i < size; i++)
         {
            printf("0x%x " , arr[i]);
         }
            cout<<endl;
      }
      if(base == 8)
      {
         for (int i = 0; i < size; i++)
         {
            printf("%o " , arr[i]);
         }
            cout<<endl;
      }
      if(base == 10)
      {
         for (int i = 0; i < size; i++)
         {
            printf("%d " , arr[i]);
         }
            cout<<endl;
      }
   }

   T getmax(){
      T maxm = 0;
      for (int i = 0; i < size; i++)
      {
         maxm  = max(maxm , arr[i]);
      }
      return maxm;      
   }

};


int main(){

   FILE * f = fopen("16-sort.txt", "r");

   int item[83];
   cout<<"hex........................................................"<<endl;

   for (int i = 0; i < 83; i++)
   {
      fscanf(f , "%x" , &item[i]);
      printf("0x%x " , item[i]);
   }
   cout<<endl;
   cout<<endl;
   try
   {
      Radix<int> r1(item , 83 , 16); 
      r1.radix_sort();
      r1.print();
      cout<<endl;
      cout<<endl;
      fclose(f);
   }
   catch( const Errors & e )
   {
      cout<<e.showError() << endl;
   }
   
   
   cout<<"oct........................................................"<<endl;
   FILE * f2 = fopen("8-sort.txt", "r");

   int item2[83];

   for (int i = 0; i < 83; i++)
   {
      fscanf(f2 , "%o" , &item2[i]);
      printf("%o " , item2[i]);
   }
   cout<<endl;
   cout<<endl;
   try
   {
        Radix<int> r2(item2 , 83 , 8);
      r2.radix_sort();
      r2.print();
      cout<<endl;
      cout<<endl;
      fclose(f2);
   }
   catch( const Errors & e )
   {
      cout<<e.showError() << endl;
   }


   FILE * f3 = fopen("10-sort.txt", "r");
   cout<<"dec........................................................"<<endl;

   int item3[83];

   for (int i = 0; i < 83; i++)
   {
      fscanf(f3 , "%d" , &item3[i]);
      printf("%d " , item3[i]);
   }
   cout<<endl;
   cout<<endl;
   try
   {
      Radix<int> r3(item3 , 83 , 10);
      r3.radix_sort();
      r3.print();
      cout<<endl;
      cout<<endl;
      fclose(f3);
   }
   catch( const Errors & e )
   {
      cout<<e.showError() << endl;
   }


   return 0;
}