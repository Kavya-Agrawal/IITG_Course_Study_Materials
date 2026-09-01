#!/bin/bash

if [ "$1" == "-g" ]; then
    threshold=$2
    shift 2
else
    echo "Teri mkc laude !!"
    exit 1
fi

sum=0

for nums in $@; do
    if [ $nums -gt $threshold ]; then
        sum=$(expr $nums + $sum)
    fi
done

# Output the sum
echo "Sum: $sum"