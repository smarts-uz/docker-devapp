FROM rabbitmq:alpine

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

RUN rabbitmq-plugins enable --offline rabbitmq_management

RUN apk update \
   && apk add mc nano wget htop nmap busybox-extras

EXPOSE 4369 5671 5672 15671 15672 25672
