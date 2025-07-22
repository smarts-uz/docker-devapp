FROM postgres:17-bookworm

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

ADD "./App/Ubuntu/installs.sh" "/installs.sh"
ADD "./postgres/installs/configs.sh" "/configs.sh"

RUN sh /installs.sh
RUN sh /configs.sh

COPY ./postgres/init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 22
