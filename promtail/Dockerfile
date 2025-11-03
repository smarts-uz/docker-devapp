FROM grafana/promtail:2.9.0

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

ARG LOKI_URL
ENV LOKI_URL=${LOKI_URL}

COPY ./promtail/conf/promtail-config.yml /etc/promtail/config.yml

VOLUME ["/var/log/postgresql"]

EXPOSE 9080

ENTRYPOINT ["/usr/bin/promtail", "-config.file=/etc/promtail/config.yml", "-config.expand-env=true"]
