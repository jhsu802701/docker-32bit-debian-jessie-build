#!/bin/bash

if [ "$(id -u)" = "0" ]; then
   echo 'This script must be run as user' 1>&2
   exit 1
fi

ABBREV=$1
OWNER='jhsu802701'
DISTRO='debian'
SUITE='jessie'
DATE=`date +%Y_%m%d_%H%M_%S`
UNAME=`whoami`

mkdir -p log
FILE_LOG="log/build-$ABBREV-$DATE.txt"
if [ $ABBREV = 'min' ]
then
  TGZ1="$DISTRO-$SUITE-min.tgz"
  TGZ2="$DISTRO-$SUITE-min-$DATE.tgz"
  sudo sh debootstrap.sh $OWNER $DISTRO $SUITE $TGZ1 $TGZ2 $UNAME 2>&1 | tee $FILE_LOG
fi
