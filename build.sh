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
TGZ1="$DISTRO-$SUITE-$ABBREV.tgz"
TGZ2="$DISTRO-$SUITE-$ABBREV-$DATE.tgz"
UNAME=`whoami`

mkdir -p log
FILE_LOG="log/build-min-$DATE.txt"
sudo sh debootstrap.sh $OWNER $DISTRO $SUITE $ABBREV $TGZ1 $TGZ2 $UNAME 2>&1 | tee $FILE_LOG
