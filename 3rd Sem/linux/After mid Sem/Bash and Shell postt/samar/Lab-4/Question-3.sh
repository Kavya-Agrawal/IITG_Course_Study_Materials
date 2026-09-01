#!/bin/bash

if [ -z $1 ]
then
    dir=$(pwd)
else
    dir=$1
fi

if [ ! -d $dir ]
then
    echo "$dir is not a valid directory"
    exit 1
fi

# Initialize counters
text_files=0
subdirs=0
links=0
char_devices=0
block_devices=0

for item in $(ls $dir)
do
    if [ -f "$item" ]; 
    then
        if file "$item" | grep -q "text"; 
        then
            text_files=$((text_files + 1))
        fi

    elif [ -d "$item" ]; then
        subdirs=$((subdirs + 1))

    elif [ -h "$item" ]; then
        links=$((links + 1))

    elif [ -c "$item" ]; then
        char_devices=$((char_devices + 1))

    elif [ -b "$item" ]; then
        block_devices=$((block_devices + 1))

    fi
done

# Output the counts
echo "Directory: $dir"
echo "Text files: $text_files"
echo "Subdirectories: $subdirs"
echo "Symbolic links: $links"
echo "Character devices: $char_devices"
echo "Block devices: $block_devices"
