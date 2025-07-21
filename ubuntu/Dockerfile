FROM ubuntu:20.04

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

ADD "./App/Ubuntu/installs.sh" "/installs.sh"
ADD "./ubuntu/installs/configs.sh" "/configs.sh"

RUN sh /installs.sh
RUN sh /configs.sh

EXPOSE 20 21 22 53/udp 53/tcp 80 443 953 8080 30000 30001 30002 30003 30004 30005 30006 30007 30008 30009 3306

