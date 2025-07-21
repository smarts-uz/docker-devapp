FROM amd64/eclipse-temurin:8u332-b09-jdk-alpine

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

ADD "./App/Alpine/installs.sh" "/installs.sh"
ADD "./eimzo/installs/configs.sh" "/configs.sh"

RUN sh /installs.sh
RUN sh /configs.sh

EXPOSE 22

