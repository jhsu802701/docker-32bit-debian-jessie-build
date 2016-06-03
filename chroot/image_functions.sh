#!/bin/bash

# Creates tgz file from chroot directory
# Example: create_tgz '32bit-debian-jessie-min-BLAH.tgz' '/var/chroot/jessie/min'
create_tgz ()
{
  TGZ_FILE=$1
  DIR_CHROOT=$2
  echo '----------------------------------'
  echo "tar cfz $TGZ_FILE -C $DIR_CHROOT ."
  tar cfz $TGZ_FILE -C $DIR_CHROOT .
  echo '----------------------'
  echo 'Recording md5sum value'
  MD5SUM1=$(md5sum $TGZ_FILE)
  echo $MD5SUM1 > "$TGZ_FILE.md5sum"
}

# Imports image from *.tgz file
# Example: import_local_image '32bit-debian-jessie-min.tgz' 'jhsu802701/32bit-debian-jessie-min'
import_local_image ()
{
  echo '---------------------------------------'
  echo "Removing old containers ($DOCKER_IMAGE)"
  for i in $(docker ps -a | grep $DOCKER_IMAGE | awk '{print $1}')
  do
    docker kill $i; wait;
    docker rm $i; wait;
  done;

  echo '---------------------------------'
  echo "docker ps -a | grep $DOCKER_IMAGE"
  docker ps -a | grep $DOCKER_IMAGE

  echo '--------------------------------'
  echo "Removing images of $DOCKER_IMAGE"
  for i in $(docker images -a | grep $DOCKER_IMAGE | awk '{print $3}')
    do
    docker kill $i; wait;
    docker rmi $i; wait;
  done;

  echo '-------------------------------------'
  echo "docker images -a | grep $DOCKER_IMAGE"
  docker images -a | grep $DOCKER_IMAGE

  TGZ_FILE=$1
  DOCKER_IMAGE=$2
  echo '---------------------------------------------'
  echo "cat $TGZ_FILE | docker import - $DOCKER_IMAGE"
  cat $TGZ_FILE | docker import - $DOCKER_IMAGE
  echo '******************************************************'
  echo "Test this new image ($DOCKER_IMAGE) before pushing it."
  echo '1. Start a new shell window.'
  echo '2. git clone https://github.com/jhsu802701/docker-32bit-debian-jessie.git'
  echo '3. sh min.sh'
  echo '4. cd min'
  echo '5. sh reset.sh'
  echo "6. In Docker, enter the command 'sh info.sh'."
  echo '7. In Docker, use the test scripts (if provided).'
  echo
  echo 'Checklist:'
  echo '* sh info.sh: This should show the initial build date and only'
  echo "  one date after this date."
  echo '* whoami: winner'
  echo '* sudo whoami: root'
  echo '* pwd: /home/winner/shared'
  echo
  read -p "Are you ready to push this new image? (y/n) " choice
  case "$choice" in 
    y|Y )
      echo '-------------------------'
      echo "docker push $DOCKER_IMAGE"
      docker push $DOCKER_IMAGE
      ;;
    * )
      echo '-------------------------'
      echo "Not pushing $DOCKER_IMAGE"
      echo 'If you wish to push this image, enter the following command:'
      echo "docker push $DOCKER_IMAGE"
    ;;
  esac
}
