# Docker Image Builder - 32-Bit Debian Jessie
This is the repository for using 32-bit Docker images based on Debian Jessie.  It is assumed here that your host OS is based on 32-bit Debian.  Docker Hub's automated build system only works for creating 64-bit images.

## Prerequisites
* You need a 32-bit Debian host OS with Git and Docker already installed.  Go to  https://github.com/jhsu802701/docker-32bit-debian-jessie-install for more details on how to install Docker.
* You should be able to use 32-bit Debian Jessie Docker images.  Go to https://github.com/jhsu802701/docker-debian-jessie for more details on how to do this.

## Other Related Links
* Docker Hub: https://hub.docker.com/r/jhsu802701/

## Building and Using Docker Images

### Scripts
Just enter the command "sh (script name).sh" to proceed.  Note that the minimal image is created from scratch.  All other images are derived from the minimal image, because Chef did not initially work during attempts to create these images from scratch.
