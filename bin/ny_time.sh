#!/bin/sh

OLDTZ=$TZ
export TZ=America/New_York
date +"%b-%d %R"
TZ=$OLDTZ
