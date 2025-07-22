#!/sbin/openrc-run

echo 'host all all 0.0.0.0/0 trust' >> /var/lib/postgresql/data/pg_hba.conf


apt-get update && apt-get install -y \
    postgresql-17-cron \
    postgresql-17-http \
    postgresql-17-pgaudit \
    postgresql-contrib && \
    rm -rf /var/lib/apt/lists/*