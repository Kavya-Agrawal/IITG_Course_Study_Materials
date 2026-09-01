#include <iostream>  
using namespace std; 

void setint(int*, int); 
int main() 
{ 
   int a,c; 
   setint(&a, 10); 
   cout << a << endl; 
   
   int* b=NULL; 
   //b =&c; //Suppose you forgot to put this line
   setint(b, 10); 
   cout << *b << endl; 
   
   return 0; 
} 

void setint(int* ip, int i)
{
   *ip = i; 
}
