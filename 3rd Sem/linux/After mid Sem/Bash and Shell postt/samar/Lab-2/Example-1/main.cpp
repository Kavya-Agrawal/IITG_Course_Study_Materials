#include<iostream>
using namespace std;

extern int Fact(int X);
extern void Hello();

int main(){
	int X, Y;
	Hello();
	cout<<" Enter Value of X:";
	cin>>X;
	Y=Fact(X);		
	cout<<"Factorial of "<<X<<" ="<<Y;
	return 0;
}
