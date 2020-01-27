#! /bin/bash
#
# script that helps practicing multilpication tables

logfile="$HOME/.fcalc-log"

date >> $logfile
while /bin/true; do
    x=`expr $RANDOM % 10`
    y=`expr $RANDOM % 10`
    rep=`expr $y \* $x`
    urep="-1"

    while [ "$urep" -ne "$rep" ]; do
        read -p "$y * $x = ?" urep
        if [ "$urep" -ne "$rep" ]; then
            echo "$y * $x = ?: $rep: WRONG" >> $logfile
        else
            echo "$y * $x = ?: $rep: CORRECT" >> $logfile

        fi
    done
done
