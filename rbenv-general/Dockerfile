FROM jhsu802701/32bit-debian-jessie-dev
MAINTAINER Jason Hsu

COPY usr_local_bin/docker-* /usr/local/bin/

# sync: needed to avoid "text file busy" error
RUN sudo chmod +x /usr/local/bin/*; sync; /usr/local/bin/docker-action; sudo rm /usr/local/bin/*

USER winner

WORKDIR /home/winner
