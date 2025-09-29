FROM postgres:17

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

ADD "./App/Ubuntu/installs.sh" "/installs.sh"
ADD "./postgres/installs/configs.sh" "/configs.sh"

RUN sh /installs.sh
RUN sh /configs.sh

COPY ./postgres/init.sql /docker-entrypoint-initdb.d/init.sql

RUN apt-get update -y && \
    apt-get install -y postgresql-17 postgresql-17-cron postgresql-17-http postgresql-17-pgaudit postgresql-contrib postgresql-17-pldebugger

EXPOSE 22