#ifndef MY_HEADER_H
#define MY_HEADER_H

#include <iostream>

/*
Include Guard (#ifndef, #define, #endif):
    #ifndef MY_HEADER_H and #define MY_HEADER_H ensure that this header file is only included once in any single compilation unit.
    Replace MY_HEADER_H with a unique identifier for each header file.
*/
// Macro for printing arrays
#define print(A) for(auto &x : A) std::cout << x << " "; std::cout << std::endl;

// Function to input array elements
void inp_array(int* arr, int n) {
    for (int i = 0; i < n; i++) {
        std::cin >> arr[i];
    }
}

#endif // MY_HEADER_H
