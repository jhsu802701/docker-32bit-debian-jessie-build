#!/bin/bash

T_START=$(date +'%s')

ABBREV=$1
OWNER=$2
DISTRO=$3
SUITE=$4

DOCKER_IMAGE="$OWNER/32bit-$DISTRO-$SUITE-$ABBREV"

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

docker build -t $DOCKER_IMAGE .

T_END=$(date +'%s')
T_ELAPSED=$(($T_END-$T_START))
echo '---------------------------------'
echo "Total time to build $DOCKER_IMAGE"
echo "$(($T_ELAPSED / 60)) minutes and $(($T_ELAPSED % 60)) seconds"

echo '------------------------------'
echo "docker run -i -t $DOCKER_IMAGE"
docker run -i -t $DOCKER_IMAGE

echo '******************************************************'
echo "Test this new image ($DOCKER_IMAGE) before pushing it."
echo '1. Start a new shell window.'
echo '2. git clone https://github.com/jhsu802701/docker-32bit-debian-jessie.git'
echo "3. sh $ABBREV.sh"
echo "4. cd $ABBREV"
echo '5. sh reset.sh'
echo "6. In Docker, enter the command 'sh info.sh'."
echo '7. In Docker, use the test scripts (if provided).'
echo
echo 'Checklist:'
echo '* sh info.sh: This should show the initial build dates and only'
echo '  one date after this date.  The first build date pertains to'
echo "  the Minimal Edition's build date.  The final build date"
echo "  pertains to that of the derivative edition."
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
