FROM <OWNER>/32bit-<DISTRO>-<SUITE>-min
MAINTAINER Jason Hsu

COPY usr_local_bin/docker-* /usr/local/bin/

# sync: needed to avoid "text file busy" error
RUN sudo chmod +x /usr/local/bin/*; sync; ls -l /usr/local/bin; sync; /usr/local/bin/docker-<ABBREV>; rm /usr/local/bin/*

USER winner

WORKDIR /home/winner
