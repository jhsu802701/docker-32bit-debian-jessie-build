#!/bin/bash

DOCKER_IMAGE='jhsu802701/debian-jessie-rbenv-general'

echo '---------------------------------------'
echo "Removing old containers ($DOCKER_IMAGE)"
for i in $(docker ps -a | grep $DOCKER_IMAGE | awk '{print $1}')
do
  docker kill $i; wait;
  docker rm $i; wait;
done;

echo '------------'
echo 'docker ps -a'
docker ps -a

echo '--------------------------------'
echo "Removing images of $DOCKER_IMAGE"
for i in $(docker images -a | grep $DOCKER_IMAGE | awk '{print $3}')
do
  docker kill $i; wait;
  docker rmi $i; wait;
done;

echo '----------------'
echo 'docker images -a'
docker images -a
