FROM datadog/squid:latest

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

RUN apt-get update -yqq && \
    apt-get -y install mc nano wget  htop nmap telnet net-tools

EXPOSE 3128

