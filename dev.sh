#!/bin/bash

if [ "$(id -u)" = "0" ]; then
   echo 'This script must be run as user' 1>&2
   exit 1
fi

ABBREV='dev'

mkdir -p log
FILE_LOG="log/build-min-$DATE.txt"
sh build.sh $ABBREV
