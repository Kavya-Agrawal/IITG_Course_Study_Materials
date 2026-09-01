#include <iostream>
#include <forward_list>
#include <bits/stdc++.h>
#include <fstream>
#include <vector>
#include <string>
#include <cmath>
using namespace std;

class node
{
private:

   int bit;
   int pos;
   node * next;

public:

   node (){
      bit = 0;
      pos = 0;
      next = NULL;
   }

   int get_bit(){
      return bit;
   }
   int get_pos(){
      return pos;
   }
   node * get_next(){
      return next;
   }

   friend class linkedlist;
   
};

class linkedlist
{
private:
   node * head;
   
public:
   void addnode (int a){
      node* new_node = new node;
      new_node->bit = a;

      int count = 0;
      if (head == nullptr) {
         head = new_node;
         // new_node
         return;
      }
      node* last = head;
      while (last->next != nullptr) {
         count++;
         last = last->next;
      }
      last->next = new_node;
      new_node->pos = count;
   }

   void addnodefront(int a){
      node * new_node = new node;
      new_node->bit = a ;
      new_node->pos = 0 ;
      new_node->next = head;
      head = new_node;

      node * temp  = head->next;
      int count = 1;

      while (temp)
      {
         temp->pos = count;
         count ++;
      }
   }

   friend ostream& operator<< (ostream& out, const linkedlist& a){
      node * curr = a.head;

      while (curr != nullptr) {
         cout << " " << curr->get_bit();
         curr = curr->get_next();
      }
      cout << endl;
      return out;
   } 

   linkedlist reverseList() {
    
      linkedlist tt;
      node *curr = head, *prev = nullptr, *next;

      while (curr != nullptr) {
         next = curr->next;
         curr->next = prev;
         prev = curr;
         curr = next;
      }
      tt.head = prev;
      return tt;
      
      // return prev;
   }



   linkedlist operator +( linkedlist & l1) const{

      // linkedlist one = *this;
      // linkedlist rone = (*this).reverseList();
      linkedlist two = l1.reverseList();

      // cout << *this;
      // cout << two;



      int carry = 0;
      node * curr1 = (*this).head;
      node * curr2 = two.head;
      linkedlist c;

      while ( curr1 && curr2)
      {
         int s = (curr1->bit + curr2->bit + carry) % 2;
         carry = (curr1->bit + curr2->bit + carry) / 2;
         c.addnode(s);
         curr1 = curr1->next;
         curr2 = curr2->next;
      }
      while (curr1)
      {
         int s = (curr1->bit + carry) % 2;
         carry = (curr1->bit + carry) / 2;
                  c.addnode(s);
         curr1 = curr1->next;
      }
      
      while (curr2)
      {
         int s = (curr2->bit + carry) % 2;
         carry = (curr2->bit + carry) / 2;
                  c.addnode(s);
         curr2 = curr2->next;
      }

      if(carry){
         c.addnode(carry);
      }

      linkedlist anslist = c.reverseList();
      cout<<anslist;
      cout<<anslist.decimal()<<endl;
      // cout<<anslist.decimal();
      return c;
      
   } 

   int getnode (int p){
      if(head == nullptr) return -1;
      node * temp  = head;
      // int count = 0;
      while (temp->pos != p and temp)
      {
         temp = temp-> next;
      }
      return temp->bit;
   }

   void deleteList(node * curr) {

      if (curr == nullptr) {
         return;
      }
      deleteList(curr->next);
      delete curr;
   }


   ~linkedlist(){
      deleteList(head);
   }

   int decimal(void){
      node* curr = head;
      int ans = 0;
      int two  = 1;
      int count  = 0;
      
      while (curr)
      {
         count++;
         curr= curr->next;
      }
      while (count--)
      {
         two*=2;
      }
      two/=2;

      node*curl = head;
      while (curl)
      {
         // if(curl->bit != -1)
            ans+=two*curl->bit;
         two/=2;
         curl = curl->next;
      }
      
      
      return ans;
   }
   
};


int main(){

// cout<<"sss";
   ifstream inFile("week08-input-02.txt");
   if(!inFile.is_open()){
      cout<<"Errrror";
   }
   else{
      linkedlist L1;
      linkedlist L2;
      forward_list<int> flist[2];

      int d = 0;
      // cout<<d <<endl;

      while (d != -1)
      {
         // cout<<"ddd";
         inFile >> d;
         // cout<<d <<endl;
         if(d!=-1 )L1.addnode(d);
      }

      int dd = 0;

      while (dd!=-1)
      {
         inFile >> dd;
         if(dd!=-1 )L2.addnode(dd);
      }

      cout<<L1;
      int val1 = L1.decimal();
      cout<<val1<<endl;
      int val2 = L2.decimal();
      cout<<L2;
      cout<<val2<<endl;

      // inFile.close();
   }

   //TASK 4
// ////// there is some small error: please do this to get complete correct ans:
// please sir, comment task4 and then run task 3 you will get correct ans:
// and then please comment task 3 and run task 4 you will get correct ans: 

      ifstream inFile2("week08-input-02.txt");
      if(!inFile2.is_open()){
         cout<<"some error ocuured in the file";
      }

      forward_list<int> flist1;
      forward_list<int> flist2;
      int num1 = 0;
      int num2 = 0;

         int x = -1;
         inFile2>>x;


         while(x!=-1){
               flist1.push_front(x);
               inFile2 >> x;
         }

         inFile2>>x;
         flist1.reverse();

         while(x!=-1){
               flist2.push_front(x);
               inFile2 >> x;
         }
         flist2.reverse();

         cout<<"first list"<<endl;
         for(forward_list<int>::iterator it = flist1.begin(); it!=flist1.end();it++){
               num1 *= 2;
               num1 += (*it);
               cout<<(*it);
         }
         
         flist1.reverse();

         cout<<"decimal is: "<<num1<<endl;

         cout<<"second list"<<endl;
         for(forward_list<int>::iterator it = flist2.begin(); it!=flist2.end();it++){
               num2 *= 2;
               num2 += (*it);
               cout<<(*it);
         }
         cout<<endl;
         flist2.reverse();

         cout<<"decimal is: "<<num2<<endl;


      forward_list<int> list_sum;

      int s=0;
      int carry=0;

      auto it1 = flist1.begin(), it2 = flist2.begin();

               while(it1 != flist1.end() && it2!=flist2.end()){
                  int s = ((*it1) + (*it2) + carry) % 2;
                  carry = ((*it1) + (*it2) + carry) / 2;
                  list_sum.push_front(s);
                  ++it1;
                  ++it2;
               }    

               while(it1 != flist1.end() ){
                  int s = ((*it1) + carry) % 2;
                  carry = ((*it1) + carry) / 2;
                  list_sum.push_front(s);
                  ++it1;
               }

               while(it2 != flist2.end() ){
                  int s = ((*it2) + carry) % 2;
                  carry = ((*it2) + carry) / 2;
                  list_sum.push_front(s);
                  ++it2;
               }


               if(carry){
                  list_sum.push_front(s);
               }

               int num3 = 0;

         // list_sum.reverse();
         for(forward_list<int>::iterator it3 = list_sum.begin(); it3!=list_sum.end();it3++){
               num3 *= 2;
               num3 += (*it3);
               cout<<(*it3);
         }

         cout<<"decimal is: "<<num3<<endl;

      
      inFile2.close();



   return 0;
}