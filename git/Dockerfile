FROM bitnami/git:2.37.1-debian-11-r8

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

ADD "./App/Ubuntu/installs.sh" "/installs.sh"
ADD "./git/installs/configs.sh" "/configs.sh"

RUN sh /installs.sh
RUN sh /configs.sh

EXPOSE 22
