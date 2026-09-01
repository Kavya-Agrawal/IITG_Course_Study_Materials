#!/bin/sh

file="data.txt"
awk '

{
    avg[$1]=($2+$3+$4) / 3
    if( $2 > max1[$1] ) max1[$1] = $2
    if( $3 > max2[$1] ) max2[$1] = $3
    if( $4 > max3[$1] ) max3[$1] = $4
}
END {
    for(stud in avg){
        if(avg[stud] <= 85 )
            print stud , avg[stud]  , "Top performer Highest Score in Subject1:" , max1[stud] , "Highest Score in Subject2:" , max2[stud] , "Highest Score in Subject3:" , max3[stud] 
        else
            print stud , avg[stud]  , "Highest Score in Subject1:" , max1[stud] , "Highest Score in Subject2:" , max2[stud] , "Highest Score in Subject3:" , max3[stud] 

    }
}


' $file