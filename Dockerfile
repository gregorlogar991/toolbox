FROM ubuntu:23.04

ADD *.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/*.sh && install.sh

CMD ["bash"]