#!/bin/sh

if [ ! -z $1 ]
then
    FORMAT=$1
else
    FORMAT="%b-%d %R"
fi
OLDTZ=$TZ
export TZ=America/New_York
date +"$FORMAT"
TZ=$OLDTZ
