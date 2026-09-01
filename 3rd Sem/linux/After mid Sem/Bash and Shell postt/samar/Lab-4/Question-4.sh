#!/bin/sh

# Function to convert month name or abbreviation into numeric form
convert_month(){
    case $1 in
        jan*|Jan*)  echo 1;;
        feb*|Feb*)  echo 2;;
        mar*|Mar*)  echo 3;;
        apr*|Apr*)  echo 4;;
        may|May)    echo 5;;
        jun*|Jun*)  echo 6;;
        jul*|Jul*)  echo 7;;
        aug*|Aug*)  echo 8;;
        sep*|Sep*)  echo 9;;
        oct*|Oct*)  echo 10;;
        nov*|Nov*)  echo 11;;
        dec*|Dec*)  echo 12;;
        [1-9]|10|11|12) echo $1;; # numeric month
        *) echo "";;               # if unrecognized, return empty string
    esac
}

# Default year to current year
current_year=$(date +"%Y")

# Function to display calendar for a range of months
show_calendars() {
    start_month=$1
    end_month=$2

    for m in $(seq $start_month $end_month); do
        cal $m $current_year
    done
}

b=0;
for item in $@; do
    if [ $item = "-" ]; then
        b=1
    fi
done

if [ $b -eq 1 ]; then
    if [ ! $# -eq 3 ]; then
        echo "Not a valid no of arguments with - "
        exit 1
    fi

    m1=$(convert_month $1)
    m2=$(convert_month $3)
    show_calendars $m1 $m2

else
    for item in $@; do
    m=$(convert_month $item)
    cal $m $current_year
done
fi