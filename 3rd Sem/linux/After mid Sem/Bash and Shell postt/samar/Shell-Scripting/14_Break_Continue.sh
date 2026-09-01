#!/bin/bash

for((i=0;i<10;i++)){
    if [ $i -eq 5 ]
    then
        break
    else
        echo $i
    fi
}

for((i=0;i<10;i++)){
    if [ $i -eq 5 ]
    then
        continue
    fi
     
    echo $i
}