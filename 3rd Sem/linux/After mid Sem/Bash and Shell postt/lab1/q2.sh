#!/bin/bash

sum=0
sum2=0

if [[ $1 == "-g"  ]]; then
   n=$3
   shift 3
else 
   echo "expecting $0 -g n num1 num2 ..."
   exit 1
fi

# echo $1

ui=("1" "2" "3")
# echo "${ui[2]}"

# for i in $ui ; do
#    echo $i
# done
for ((i = 0; i < 10; i++ )); do
   echo "${ui[$i]}"
done

# for num in "$@"; do
#    if [[ $num -gt $n ]]; then
#       echo "$num"
#       ((sum = sum + num))
#    fi
#    # sum2=$((sum2+num))
#    # ((sum = sum + $num))
# done

# for ((i = 0; i < 10; i++ )) ;do
#    echo "${$@[@]:0:4}"
#    # echo $i
# # done

# echo $sum
# echo $sum2