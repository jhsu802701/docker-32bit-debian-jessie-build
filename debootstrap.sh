#!/bin/bash

# Based on
# https://github.com/docker-32bit/debian/blob/i386/build-image.sh
# and
# https://github.com/docker/docker/blob/master/contrib/mkimage.sh

# Other resources:
# https://l3net.wordpress.com/2013/09/21/how-to-build-a-debian-livecd/
# https://www.opengeeks.me/2015/04/build-your-hybrid-debian-distro-with-xorriso/
# https://www.reversengineered.com/2014/05/17/building-and-booting-debian-live-over-the-network/

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

T_START=$(date +'%s')

# Make functions in the files below available for use
. chroot/chroot_functions.sh
. chroot/image_functions.sh

OWNER=$1
DISTRO=$2
SUITE=$3
ABBREV=$4
TGZ1=$5
TGZ2=$6
UNAME=$7

# Settings
ARCH=i386
DIR_CHROOT_ABBREV="/var/chroot/$SUITE/$ABBREV"
APT_MIRROR='http://httpredir.debian.org/debian'
DOCKER_IMAGE="$OWNER/32bit-$DISTRO-$SUITE-$ABBREV"

echo '-----------------'
echo 'Build parameters:'
echo "Architecture: $ARCH"
echo "Suite: $SUITE"
echo "Chroot directory: $DIR_CHROOT_ABBREV"
echo "Apt-get mirror: $APT_MIRROR"
echo "Docker image: $DOCKER_IMAGE"
echo '---------------------------'

# CHROOT OPERATIONS
create_debian $OWNER $SUITE $ABBREV $DIR_CHROOT_ABBREV

# CHROOT -> TGZ
TGZ_SHORT=$TGZ1
TGZ_LONG=$TGZ2
create_tgz $TGZ_LONG $DIR_CHROOT_ABBREV
rm $TGZ_SHORT
cp $TGZ_LONG $TGZ_SHORT

# OUTPUT FILES: change ownership to user
chown $UNAME:users $TGZ_SHORT
chown $UNAME:users $TGZ_LONG
chown $UNAME:users $TGZ_LONG.md5sum

T_END=$(date +'%s')
T_ELAPSED=$(($T_END-$T_START))
echo '-------------'
echo 'Time elapsed:'
echo "$(($T_ELAPSED / 60)) minutes and $(($T_ELAPSED % 60)) seconds"

# TGZ -> IMAGE
import_local_image $TGZ_LONG $DOCKER_IMAGE
