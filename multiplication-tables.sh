#! /bin/bash
#
# tafels: script dat helpt met oefenen van tafels

logfile="$HOME/.fcalc-log"

date >> $logfile
while /bin/true; do
    if [ "$(expr $RANDOM % 100)" -lt "70" ]; then
        x=`expr $(expr $RANDOM % 4) + 6`
    else
        x=`expr $RANDOM % 5` 
    fi
    y=`expr $RANDOM % 10`
    rep=`expr $y \* $x` 
    urep="-1"
    
    while [ "$urep" -ne "$rep" ]; do
        read -p "$y * $x = ?" urep
        if [ "$urep" -ne "$rep" ]; then 
            echo "$y * $x = ?: $rep: WRONG" >> $logfile
            beep
        else
            echo "$y * $x = ?: $rep: CORRECT" >> $logfile
            
        fi
    done
done

