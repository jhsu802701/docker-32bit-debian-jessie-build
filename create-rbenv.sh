#!/bin/bash

ABBREV_DEF='rbenv-test'

# Output:
# First argument if it is not blank
# Second argument if first argument is blank
anti_blank () {
  if [ -z "$1" ]; then
    echo $2
  else
    echo $1
  fi
}

echo '***********************************************'
echo 'Creating scripts and files for creating/using a'
echo 'new project-specific rbenv Docker image.'
echo
echo 'NOTE: Running this script adds files tracked by Git.'
echo
echo "DEFAULT VALUE: $ABBREV_DEF"
echo 'Enter the abbreviation of your new project (rbenv-rubymn, rbenv-rubygems, etc.):'
read ABBREV_SEL
ABBREV=$(anti_blank $ABBREV_SEL $ABBREV_DEF)
echo

# Copy and update rbenv-general.sh
echo '-------------------'
echo "Updating $ABBREV.sh"
cp rbenv-general.sh $ABBREV.sh
sed -i "s/rbenv-general/$ABBREV/g" $ABBREV.sh

# Copy and update usr_local_bin/docker-rbenv-general and usr_local_bin/docker-rbenv-general-*
echo '-----------------------------'
echo 'Updating the following files:'
echo "usr_local_bin/docker-$ABBREV"
echo "usr_local_bin/docker-$ABBREV-check"
echo "usr_local_bin/docker-$ABBREV-root"
echo "usr_local_bin/docker-$ABBREV-user"

cp usr_local_bin/docker-rbenv-general usr_local_bin/docker-$ABBREV
sed -i "s/rbenv-general/$ABBREV/g" usr_local_bin/docker-$ABBREV

cp usr_local_bin/docker-rbenv-general-check usr_local_bin/docker-$ABBREV-check
sed -i "s/rbenv-general/$ABBREV/g" usr_local_bin/docker-$ABBREV-check

cp usr_local_bin/docker-rbenv-general-root usr_local_bin/docker-$ABBREV-root
sed -i "s/rbenv-general/$ABBREV/g" usr_local_bin/docker-$ABBREV-root

cp usr_local_bin/docker-rbenv-general-user usr_local_bin/docker-$ABBREV-user
sed -i "s/rbenv-general/$ABBREV/g" usr_local_bin/docker-$ABBREV-user

echo '********************************************************'
echo "The new files for the $ABBREV edition have been created."
echo 'The tasks left for you are:'
echo "1. Customizing usr_local_bin/docker-$ABBREV-root and usr_local_bin/docker-$ABBREV-user"
echo "2. sh $ABBREV.sh"
echo "3. Updating Git"
