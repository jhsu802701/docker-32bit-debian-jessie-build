FROM <OWNER>/32bit-<DISTRO>-<SUITE>-min
MAINTAINER Jason Hsu

# sync: needed to avoid "text file busy" error
RUN sudo chmod +x /usr/local/bin/*; sync; /usr/local/bin/docker-<ABBREV>

USER winner

WORKDIR /home/winner
