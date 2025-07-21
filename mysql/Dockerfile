FROM mysql:8.0.29-debian

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

ADD "./App/Ubuntu/installs.sh" "/installs.sh"
ADD "./mysql/installs/configs.sh" "/configs.sh"

RUN sh /installs.sh
RUN sh /configs.sh

EXPOSE 22

