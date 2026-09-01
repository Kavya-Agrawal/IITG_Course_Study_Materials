#!/bin/bash

#taking the hours input
hours=$(date +%H)

if [ $hours -ge 5 ] && [ $hours -lt 12 ]; then
    echo "Good morning!"
elif [ $hours -ge 12 ] && [ $hours -lt 18 ]; then
    echo "Good afternoon!"
else
    echo "Good night!"
fi