FROM postgrest/postgrest:v13.0.4

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG ROOT_PASSWORD
ENV ROOT_PASSWORD $ROOT_PASSWORD

ENV PGRST_DB_URI $ROOT_PASSWORD


EXPOSE 22
