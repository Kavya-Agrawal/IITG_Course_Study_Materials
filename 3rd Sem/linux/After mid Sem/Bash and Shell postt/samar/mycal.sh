#!/bin/sh

# Check the number of arguments provided and assign month and year accordingly
case $# in
    0) set `date`; m=$2; y=$7 ;;   # no args: use today (month from $3, year from $6)
    1) m=$1; set `date`; y=$7 ;;   # 1 arg: use the provided month, current year from $6
    2) m=$1; y=$2;;               # 2 args: use provided month and year
esac

# Convert month name or abbreviation into numeric form (if necessary)
case $m in
    jan*|Jan*)      m=1;;
    feb*|Feb*)      m=2;;
    mar*|Mar*)      m=3;;
    apr*|Apr*)      m=4;;
    may|May)        m=5;;
    jun*|Jun*)      m=6;;
    jul*|Jul*)      m=7;;
    aug*|Aug*)      m=8;;
    sep*|Sep*)      m=9;;
    oct*|Oct*)      m=10;;
    nov*|Nov*)      m=11;;
    dec*|Dec*)      m=12;;
    [1-9]|10|11|12) ;;             # numeric month: no changes needed
    *)              y=$m; m="";;   # plain year: set year, clear month
esac

# Display the calendar for the specified month and year
cal $m $y
