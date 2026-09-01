#!/bin/bash

sum=0

for nums in $@; do
    sum=$(expr $sum + $nums)
done

# Output the sum
echo "Sum: $sum"