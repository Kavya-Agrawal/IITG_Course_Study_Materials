#!/bin/bash

time=$(date "+%H")

if [[ $time -gt 04 && $time -lt 13 ]]; then
   echo "God morning"
elif [[ $time -gt 11 && $time -lt 19 ]]; then
   echo "God noont"
else 
   echo "night"
fi