#include <bits/stdc++.h>
#include <vector>
#include <string>
using namespace std;
typedef long long ll;
typedef unsigned long long ull;




class Errors {
private:
   string errors;
public:
   Errors(const string& message) : errors(message) {}
   string showError() const {
      return errors;
   }
};

const int maxsize= 10000;


template <typename T>
class Heap
{
private:
   T arr[maxsize];
   int size = 0;
public:
   void insert (T x) { 
      if(size == maxsize){
         throw Errors("Memeory limit exceded!!!!!!!!!!!");
      }
      // if ( search(x) ) {
      //    cout<<x <<"  :";
      //    throw Errors("Duplicates elements are not allowed!"); //////////Told by the SIR insert duplicates/////////
      // }
      // else
      // {
         size++; 
         int i = size - 1; 
         arr[i] = x; 
         while (i != 0 && arr[(i - 1) / 2] > arr[i]) { 
            swap(arr[i], arr[(i - 1) / 2]); 
            i = (i - 1) / 2; 
         } 
         
         return;         
      // }
      
   }

   void MinHeapify(int i) { 
      int l = 2*i+1; 
      int r = 2*i+2; 
      int smallest = i; 

      if (l < size && arr[l] < arr[i]) 
         smallest = l; 
      if (r < size && arr[r] < arr[smallest]) 
         smallest = r; 

      if (smallest != i) { 
         swap(arr[i], arr[smallest]); 
         MinHeapify(smallest); 
      } 
   } 

   T deletemin(void) { 
      if (size <= 0) {
         throw Errors("No root to delete !!!");
      } 
      if (size == 1) { 
         size--; 
         return arr[0]; 
      } 
      T root = arr[0]; 
      arr[0] = arr[size - 1]; 
      size--; 

      MinHeapify(0); 
      return root; 
   } 

   bool search(T data){
      for (int i = 0; i < size; i++)
      {
         if(arr[i] == data) return 1;
      }
      return 0;      
   }

   void updateRoot(T a){
      if(size <= 0 ){
         throw Errors("Nothing to update!!!!!!!!!!!");
      }
      // if ( search(a) ) {
      //    cout<<a <<"  :";
      //    throw Errors("Duplicates elements needn't be updated!"); //////Told by the SIR to update to duplicates//////
      // }
      arr[0] = a;
      MinHeapify(0);
   }

   void print(void){
      for( int i = 0; i < size; i++ ){ 
         cout << fixed << setprecision(1) << arr[i] <<" "; 
      }
      cout << endl;
   }   
};

int main(){


   ifstream inFile("int-heap.txt");
   if(!inFile.is_open()){
      cout<<" Errrorr"<<endl;
   }
   else{
      string a;
      cout<<endl;
      cout<<endl;
      cout<<"...............int Heap..........................................................";
      cout<<endl;

      Heap<int> H;

      while (inFile >> a)
      {
         if(a == "insert")
         {
            int num;
            inFile >> num;
            // cout<<a << num<<endl;
            try
            {
               H.insert(num);
            }
            catch(const Errors & e)
            {
               cout << e.showError() << '\n';
            }
         }
         else if(a == "delete"){
            int num;
            inFile >> num;
            continue;
         }
         else if(a == "update"){
            int num;
            inFile >> num;
            try
            {
               H.updateRoot(num);
            }
            catch(const Errors & e)
            {
               cout << e.showError() << '\n';
            } 
         }
         else if(a == "print"){
            cout<<endl;
            H.print();
            cout<<endl;
         }
         else if(a == "search"){
            int num;
            inFile >> num;
            if(H.search(num)){
               cout << num<<" : FOUND. Search is sucessful." << endl;
            }
            else {
               cout << num<<" : NOT FOUND. Search is unsucessful." << endl;
               
            }
         }
         else {
            int num;
            inFile >> num;
            try
            {
               throw Errors("Invalid INPUT");
            }
            catch( const Errors & e )
            {
                  cout<<a <<endl;
                  cout<<e.showError() << endl;
            }
         }
         
      }
      inFile.close();
   
   
   }
   ifstream inFile2("float-heap.txt");
   if(!inFile2.is_open()){
      cout<<" Errrorr"<<endl;
   }
   else{
      string a;
      cout<<endl;
      cout<<endl;
      cout<<"...............float Heap..........................................................";
      cout<<endl;

      Heap<float> H;

      while (inFile2 >> a)
      {
         if(a == "insert")
         {
            float num;
            inFile2 >> num;
            // cout<<a << num<<endl;
            try
            {
               H.insert(num);
            }
            catch(const Errors & e)
            {
               cout << e.showError() << '\n';
            }
         }
         else if(a == "delete"){
            float num;
            inFile2 >> num;
            continue;
         }
         else if(a == "update"){
            float num;
            inFile2 >> num;
            try
            {
               H.updateRoot(num);
            }
            catch(const Errors & e)
            {
               cout << e.showError() << '\n';
            } 
         }
         else if(a == "print"){
            cout<<endl;
            H.print();
            cout<<endl;
         }
         else if(a == "search"){
            float num;
            inFile2 >> num;
            if(H.search(num)){
               cout << num<<" : FOUND. Search is sucessful." << endl;
            }
            else {
               cout << num<<" : NOT FOUND. Search is unsucessful." << endl;
               
            }
         }
         else {
            float num;
            inFile2 >> num;
            try
            {
               throw Errors("Invalid INPUT");
            }
            catch( const Errors & e )
            {
                  cout<<a <<endl;
                  cout<<e.showError() << endl;
            }
         }
         
      }
      inFile2.close();
   
   
   }
   ifstream inFile3("string-heap.txt");
   if(!inFile3.is_open()){
      cout<<" Errrorr"<<endl;
   }
   else{
      string a;
      cout<<endl;
      cout<<endl;
      cout<<"...............string Heap..........................................................";
      cout<<endl;

      Heap< string > H;

      while (getline(inFile3 , a))
      {
         // string op = a.substr(0 , a.find(" ") );
         // string val = a.substr(a.find(" ") + 1 , a.length() - a.find(" ") -1 );
         string op = "";
         string val = "";
         int i = 0;
         for ( ; i < a.size(); i++)
         {
            if(a[i] == ' ') break;
            else op+=a[i];
         }
         for (i = i+1 ; i < a.size(); i++)
         {
             val+=a[i];
         }
         
         if(op == "insert")
         {
            try
            {
               H.insert(val);
            }
            catch(const Errors & e)
            {
               cout << e.showError() << '\n';
            }
         }
         else if(op == "delete"){
            continue;
         }
         else if(op == "update"){
            try
            {
               H.updateRoot(val);
            }
            catch(const Errors & e)
            {
               cout << e.showError() << '\n';
            } 
         }
         else if(op == "print"){
            cout<<endl;
            H.print();
            cout<<endl;
         }
         else if(op == "search"){
            if(H.search(val)){
               cout << val<<" : FOUND. Search is sucessful." << endl;
            }
            else {
               cout << val<<" : NOT FOUND. Search is unsucessful." << endl;
               
            }
         }
         else {
            try
            {
               throw Errors("Invalid INPUT");
            }
            catch( const Errors & e )
            {
                  cout<<op <<endl;
                  cout<<e.showError() << endl;
            }
         }
         
      }
      inFile3.close();
   
   
   }
   ifstream inFile4("char-heap.txt");
   if(!inFile4.is_open()){
      cout<<" Errrorr"<<endl;
   }
   else{
      string a;
      cout<<endl;
      cout<<endl;
      cout<<"...............char Heap..........................................................";
      cout<<endl;

      Heap<char> H;

      while (inFile4 >> a)
      {
         if(a == "insert")
         {
            char num;
            inFile4 >> num;
            // cout<<a << num<<endl;
            try
            {
               H.insert(num);
            }
            catch(const Errors & e)
            {
               cout << e.showError() << '\n';
            }
         }
         else if(a == "delete"){
            char num;
            inFile4 >> num;
            continue;
         }
         else if(a == "update"){
            char num;
            inFile4 >> num;
            try
            {
               H.updateRoot(num);
            }
            catch(const Errors & e)
            {
               cout << e.showError() << '\n';
            } 
         }
         else if(a == "print"){
            cout<<endl;
            H.print();
            cout<<endl;
         }
         else if(a == "search"){
            char num;
            inFile4 >> num;
            if(H.search(num)){
               cout << num<<" : FOUND. Search is sucessful." << endl;
            }
            else {
               cout << num<<" : NOT FOUND. Search is unsucessful." << endl;
               
            }
         }
         else {
            char num;
            inFile4 >> num;
            try
            {
               throw Errors("Invalid INPUT");
            }
            catch( const Errors & e )
            {
                  cout<<a <<endl;
                  cout<<e.showError() << endl;
            }
         }
         
      }
      inFile4.close();
   
   
   }

   return 0;
}