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
else
  echo ''
  echo 'The Docker image you are about to build is based on'
  echo "$OWNER/32bit-$DISTRO-$SUITE-min."
  echo 'Check the age of the latest version at'
  echo "https://hub.docker.com/r/$OWNER/32bit-$DISTRO-$SUITE-min/."
  echo 'If the latest version of this base image is more than a few'
  echo 'weeks old, you should build and upload a new one first with the'
  echo 'min.sh command.'
  echo
  read -p 'Do you wish to continue? (Y/N) ' choice1
  case "$choice1" in 
    y|Y )
      case "$choice2" in
        y|Y )
          bash template.sh $ABBREV 2>&1 | tee $FILE_LOG
        ;;
        * )
          echo '--------------------------'
          echo "Aborting the build process"
        ;;
      esac
    ;;
    * )
      echo '--------------------------'
      echo "Aborting the build process"
    ;;
  esac
fi
