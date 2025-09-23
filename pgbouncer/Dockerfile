FROM edoburu/pgbouncer:v1.24.1-p1

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

# ARG ROOT_PASSWORD
# ENV ROOT_PASSWORD $ROOT_PASSWORD
USER postgres
USER root
ADD "./App/Alpine/installs.sh" "/installs.sh"
ADD "./pgbouncer/installs/configs.sh" "/configs.sh"

RUN sh /installs.sh
# RUN sh /configs.sh
USER postgres

EXPOSE 22