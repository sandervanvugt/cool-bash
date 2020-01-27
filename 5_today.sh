#!/bin/bash
#
# displays current day, month, year

DATE=`date +%d-%m-%y`
echo $DATE

TODAY=${DATE%%-*}
BLAH=${DATE%-*}
THISMONTH=${BLAH##*-}
THISYEAR=${DATE##*-}

echo Today is $TODAY
echo This month is $THISMONTH
echo This year is $THISYEAR

