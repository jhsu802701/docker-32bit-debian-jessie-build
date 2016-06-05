#!/bin/bash

if [ "$(id -u)" = "0" ]; then
   echo 'This script must be run as user' 1>&2
   exit 1
fi

ABBREV=$1
OWNER='jhsu802701'
DISTRO='debian'
SUITE='jessie'
DIR_TMP_ABBREV="tmp-$ABBREV"

echo '--------------------------------------'
echo "Setting up $DIR_TMP_ABBREV environment"
rm -rf $DIR_TMP_ABBREV
mkdir $DIR_TMP_ABBREV
mkdir $DIR_TMP_ABBREV/usr_local_bin
cp template/* $DIR_TMP_ABBREV
cp usr_local_bin/docker-$ABBREV $DIR_TMP_ABBREV/usr_local_bin
cp usr_local_bin/docker-$ABBREV-* $DIR_TMP_ABBREV/usr_local_bin

echo 'NOTICE:' > $DIR_TMP_ABBREV/README.txt
echo 'Files in this directory are created with an automated script.' >> $DIR_TMP_ABBREV/README.txt
echo 'Changes made here will be wiped out.' >> $DIR_TMP_ABBREV/README.txt

fill_in_params () {
  FILE_TO_UPDATE=$1
  sed -i.bak "s/<ABBREV>/$ABBREV/g" $FILE_TO_UPDATE
  sed -i.bak "s/<OWNER>/$OWNER/g" $FILE_TO_UPDATE
  sed -i.bak "s/<DISTRO>/$DISTRO/g" $FILE_TO_UPDATE
  sed -i.bak "s/<SUITE>/$SUITE/g" $FILE_TO_UPDATE
  rm $FILE_TO_UPDATE.bak
}

fill_in_params $DIR_TMP_ABBREV/Dockerfile

cd $DIR_TMP_ABBREV && sh build.sh "$ABBREV" "$OWNER" "$DISTRO" "$SUITE"
