/*
---------------------------------------------------------
Author        : Kavya Kumar Agarwal
Roll Number   : 230101053
Assignment    : Assignment 1
Task          : Task 1 – Bubble Sort Algorithm

Description:
This program reads integer values from an input file,
validates the data, and sorts the numbers using the
Bubble Sort algorithm. After each pass of sorting,
the intermediate result is displayed.
---------------------------------------------------------
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <limits.h>

/* 
Function Name : displayArray
Purpose       : Prints all elements of the array
Parameters    : data[]  -> array of integers
                length -> number of elements
*/
void displayArray(int data[], int length)
{
    int idx;
    for (idx = 0; idx < length; idx++)
    {
        printf("%d ", data[idx]);
    }
    printf("\n");
}

/*
Function Name : performBubbleSort
Purpose       : Sorts the array using Bubble Sort
                and prints array after each pass
*/
void performBubbleSort(int data[], int length)
{
    int pass, index, temp;

    printf("\nPasses:\n");

    /* Outer loop controls number of passes */
    for (pass = 0; pass < length - 1; pass++)
    {
        /* Inner loop performs comparison and swapping */
        for (index = 0; index < length - pass - 1; index++)
        {
            if (data[index] > data[index + 1])
            {
                temp = data[index];
                data[index] = data[index + 1];
                data[index + 1] = temp;
            }
        }

        /* Print array after each pass */
        printf("Pass %d: ", pass + 1);
        displayArray(data, length);
    }
}

/*
Function Name : validateIntegerString
Purpose       : Checks whether a string is a valid integer
Return Value  : 1 if valid, 0 otherwise
*/
int validateIntegerString(const char *input)
{
    /* Empty string check */
    if (input == NULL || *input == '\0')
        return 0;

    /* Allow negative sign */
    if (*input == '-')
        input++;

    /* Ensure at least one digit exists */
    if (*input == '\0')
        return 0;

    /* Check all remaining characters are digits */
    while (*input)
    {
        if (!isdigit(*input))
            return 0;
        input++;
    }

    return 1;
}

int main()
{
    FILE *fp;
    int *numbers = NULL;
    int count = 0;
    char buffer[100];

    /* Open input file */
    fp = fopen("input.txt", "r");
    if (fp == NULL)
    {
        printf("Error: Unable to open input file.\n");
        return 1;
    }

    /* First pass: validate input and count numbers */
    while (fscanf(fp, "%s", buffer) == 1)
    {
        if (!validateIntegerString(buffer))
        {
            printf("Invalid input detected: '%s' is not numeric.\n", buffer);
            fclose(fp);
            return 1;
        }

        /* Check for integer range overflow */
        long value = strtol(buffer, NULL, 10);
        if (value > INT_MAX || value < INT_MIN)
        {
            printf("Invalid input: '%s' exceeds integer limits.\n", buffer);
            fclose(fp);
            return 1;
        }

        count++;
    }

    /* Handle empty file case */
    if (count == 0)
    {
        printf("Error: Input file is empty.\n");
        fclose(fp);
        return 1;
    }

    /* Allocate memory for array */
    numbers = (int *)malloc(count * sizeof(int));
    if (numbers == NULL)
    {
        printf("Error: Memory allocation failed.\n");
        fclose(fp);
        return 1;
    }

    /* Reset file pointer to beginning */
    rewind(fp);

    /* Second pass: read values into array */
    for (int i = 0; i < count; i++)
    {
        fscanf(fp, "%s", buffer);
        numbers[i] = (int)strtol(buffer, NULL, 10);
    }

    fclose(fp);

    /* Display original array */
    printf("Original array: ");
    displayArray(numbers, count);

    /* Perform Bubble Sort */
    performBubbleSort(numbers, count);

    /* Display final sorted array */
    printf("\nFinal sorted array: ");
    displayArray(numbers, count);

    free(numbers);
    return 0;
}
