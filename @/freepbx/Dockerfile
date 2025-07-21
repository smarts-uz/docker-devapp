FROM tiredofit/freepbx:latest

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

RUN apk update \
   && apk add mc nano wget htop nmap busybox-extras
