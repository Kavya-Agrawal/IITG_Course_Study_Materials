#!/bin/bash

if [[ -z $1 || ! -d $1 ]] ; then
 echo "expectat $0 dirname"
 exit 1
fi

text_files=$( find $1 -type f -name "*" | wc -l )
text_files2=0

# sub_dirs=0
# links=0
# char_devices=0
# block_devices=0

for i in "$1"/* ; do
   if [[ -f "$i" ]] ; then
      ((text_files2++))
      echo "yyyyyyyyyyyyy"
   fi
done

echo "$text_files"
echo $text_files2