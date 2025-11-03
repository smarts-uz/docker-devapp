FROM grafana/promtail:2.9.0

LABEL maintainer="Asror Zakirov <asror.zk@gmail.com>"

COPY ./promtail/conf/promtail-config.yml /etc/promtail/config.yml

VOLUME ["/var/log/postgresql"]

EXPOSE 9080

ENTRYPOINT ["/usr/bin/promtail", "-config.file=/etc/promtail/config.yml"]
