#!/sbin/openrc-run

echo 'host all all 0.0.0.0/0 trust' >> /var/lib/postgresql/data/pg_hba.conf

apt-get -yqq update
apt-get -y install postgresql-17-cron
apt-get -y install postgresql-17-http 
apt-get -y install postgresql-17-pgaudit 
apt-get -y install postgresql-contrib