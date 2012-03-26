#!/bin/sh

OLDTZ=$TZ
export TZ=America/New_York
date +"$1"
TZ=$OLDTZ
