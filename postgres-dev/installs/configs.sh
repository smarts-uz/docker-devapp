#!/sbin/openrc-run

echo 'host all all 0.0.0.0/0 trust' >> /var/lib/postgresql/data/pg_hba.conf
