#!/bin/bash

greetings(){
    echo "Good Morning !!"
}

greetings

sum(){
    a=$1
    b=$2
    c=$(($a+$b))

    echo "The sum of $a and $b is: " $c
    return $c
}

sum 12 56
retr=$?

