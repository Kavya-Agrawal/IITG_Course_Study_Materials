#include<iostream>
#include"H_file.h"
using namespace std;

int main(){
    int n;
    cin>>n;
    int arr[n];
    inp_array(arr,n);
    print(arr);
    return 0;
}
