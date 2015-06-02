#!/bin/sh

if [ ! -z $1 ]
then
    FORMAT=$1
else
    FORMAT="%d %b"
fi
OLDTZ=$TZ
export TZ=US/Pacific
date +"$FORMAT"
TZ=$OLDTZ
