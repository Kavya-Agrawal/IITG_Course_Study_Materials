#!/bin/bash

read -p "Enter grade: " grade

case $grade in 
    A)
        echo "91-100"
        ;;
    B)
        echo "81-90"
        ;;
    C)
        echo "71-80"
        ;;
    *)
        echo "<=70"
esac