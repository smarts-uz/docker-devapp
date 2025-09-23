FROM teamprodevs/proliga-front:local

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

USER root

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

COPY ./App/Alpine/installs.sh /installs.sh



RUN sh /installs.sh

USER appuser

EXPOSE 22
