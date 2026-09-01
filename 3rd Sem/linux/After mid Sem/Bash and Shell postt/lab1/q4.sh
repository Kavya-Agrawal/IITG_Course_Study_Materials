#!/bin/sh
convert_month () {
    case $m in
        jan*|Jan*)		m=1;;
        feb*|Feb*) 		m=2;;
        mar*|Mar*) 		m=3;;
        apr*|Apr*) 		m=4;;
        may | May)		m=5;;
        jun*|Jun*)		m=6;;
        jul*|Jul*)		m=7;;
        aug*|Aug*)		m=8;;
        sep*|Sep*)		m=9;;
        oct*|Oct*)		m=10;;
        nov*|Nov*)		m=11;;
        dec*|Dec*) 		m=12;;
        [1-9]|10|11|12)	;;				#numeric month
        *)				y=$m; m="";;	#plain year
    esac 
}
current_year=$(date +"%Y")
show_calendar () {
    for m in $(seq $1 $2); do
        cal $m $current_year
    done
}
b=0
for i in $@; do 
    if [[ $i == "-"]]; then
        ((b++))
    fi
done
if [[ $b -eq 1 ]] ; then
    local fir=$(convert_month $1)
    local sec=$(convert_month $3)
    show_calendar $fir $sec
else    
    local fir=$(convert_month $1)
    local sec=$(convert_month $2)
    show_calendar $fir $sec
fi