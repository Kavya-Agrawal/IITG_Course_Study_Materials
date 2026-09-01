#include <bits/stdc++.h>
#include <vector>
#include <string>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#include <functional> // for less
using namespace std;
using namespace __gnu_pbds;
typedef long long ll;
typedef unsigned long long ull;

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

template<typename T>
class stackk
{
private:
   int top;
   int capacity;
   queuee <T> * q1;
   queuee <T> * q2;
   T * data;

public:

   stackk( int c ){
      capacity = c;
      top = -1;
      data = new T[c];
      q1 = new queuee <T>(c);
      q2 = new queuee <T>(c);

      // cout<<capacity<<"ddddddddddddddd"<<endl;

   }

   ~stackk ()
   {
      delete[] data;
      delete q1;
      delete q2;
   }
   
   void push( const T & a ){
      if (top >= (capacity - 1)) {
         cout << "Stack Overflow";
         return;
      }
      else {
         data[++top] = a;
         // cout<<data[top]<<"ddddddddddddddd"<<endl;
         return;
      }
   }

   T pop(){
      if (top < 0) {
         cout << "Stack Underflow";
         __throw_out_of_range("underrrrrrrrrrrrrr");
      }
      else {
         T x = data[top--];
         return x;
      }
   }

   T & topp()
   {
      if (top == -1) {
         cout << "Stack is Empty";
         // T a;
         // return a;
         __throw_out_of_range("underrrrrrrrrrrrrr");
      }
      else {
         // T x = data[top];
         return data[top];
      }
   }

   bool isEmpty()
   {
      return (top < 0);
   }

   int getsize(){
      return capacity;
   }

   void sortstack(){
      
      q1->enque(pop());

      while (!isEmpty())
      {
         // if(q1->isempty()){
         //    q1->enque(pop());
         //    continue;
         // }

         while (!q1->isempty() and q1->getFront() > topp() ) 
         {
            q2->enque(q1->dequeue());
            // q1->dequeue();
         }
         if(!this->isEmpty()){
            q2->enque(pop());
         }
         // q1->enque(pop());
         while (!q1->isempty())
         {
            q2->enque(q1->dequeue());
            // q1->dequeue();
         }
         while (!q2->isempty())
         {
            q1->enque(q2->dequeue());
         } 
         
      }


      // cout<<"ttttttttttttttttt"<< (q1->isempty())<<endl;
      while (!q1->isempty())
      {
         // cout<<q1->size<<endl;
         push(q1->dequeue());
      }
      // printstack();
   }

   void printstack(){

      // int size = capacity;
         
      while (!isEmpty())
      {
         // T temp = topp();
         cout<<pop()<<" ";
         // pop();
      }
   }


};

int main(){

   ifstream infile("int-sort.txt");
   if(!infile.is_open()){
      cout<<"eroeeeeeeeeeeeeeee" << endl;
   }
   else{


      int num;
      infile >> num;
      // cout<<num<<endl;
      // int temp;
      stackk<int> s(num);
      for (int i = 0; i < num; i++)
      {
         int temp;
         infile>>temp;
         // cout<<temp<<" ";
         s.push(temp);
      }

      cout<<endl;
      cout<<endl;
      cout<<"Int file sorted...................................." <<endl;
      s.sortstack();

      s.printstack();
      cout<<endl;
      cout<<endl;
      

      infile.close();
   }
   ifstream infile2("char-sort.txt");
   if(!infile2.is_open()){
      cout<<"eroeeeeeeeeeeeeeee" << endl;
   }
   else{


      int num;
      infile2 >> num;
      // cout<<num<<endl;
      // char temp;
      stackk<char> s(num);
      for (int i = 0; i < num; i++)
      {
         char temp;
         infile2>>temp;
         // cout<<temp<<" ";
         s.push(temp);
      }

      cout<<"Char file sorted...................................." <<endl;
      s.sortstack();

      s.printstack();
      cout<<endl;
      cout<<endl;
      

      infile2.close();
   }
   ifstream infile3("float-sort.txt");
   if(!infile3.is_open()){
      cout<<"eroeeeeeeeeeeeeeee" << endl;
   }
   else{


      int num;
      infile3 >> num;
      // cout<<num<<endl;
      // char temp;
      stackk<float> s(num);
      for (int i = 0; i < num; i++)
      {
         float temp;
         infile3>>temp;
         // cout<<temp<<" ";
         s.push(temp);
      }

      cout<<"float file sorted...................................." <<endl;
      s.sortstack();

      s.printstack();
      cout<<endl;
      cout<<endl;
      

      infile3.close();
   }
   ifstream infile4("string-sort.txt");
   if(!infile4.is_open()){
      cout<<"eroeeeeeeeeeeeeeee" << endl;
   }
   else{


      int num;
      infile4 >> num;
      // cout<<num<<endl;
      // char temp;
      stackk<string> s(num);
      for (int i = 0; i < num; i++)
      {
         string temp;
         infile4>>temp;
         // cout<<temp<<" ";
         s.push(temp);
      }

      cout<<"string file sorted...................................." <<endl;
      s.sortstack();

      s.printstack();
      cout<<endl;
      cout<<endl;
      

      infile4.close();
   }

   return 0;
}