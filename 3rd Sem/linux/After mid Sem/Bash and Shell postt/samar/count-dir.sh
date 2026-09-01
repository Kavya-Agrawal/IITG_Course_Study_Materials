#!/bin/bash

count=0

for fname in $(ls)
do
    if [ -d "$fname" ]   # Check if it's a directory
    then
        count=$((count + 1))   # Increment the count
    fi
done

echo "The number of directories is: $count"
