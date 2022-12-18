FROM ubuntu:23.04
LABEL org.opencontainers.image.source="https://github.com/gregorlogar991/toolbox"

ADD *.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/*.sh && install.sh

CMD ["bash"]