docker-compose up postgres -d
docker-compose up pgrest -d
docker-compose up postgres portainer nginx PostgREST -d

docker-compose up postgres portainer -d
docker-compose up nginx-app -d
docker-compose up nginx-app node-proliga  -d

docker-compose rm --force --stop pgrest & docker-compose up pgrest -d

docker compose up postgres pgrest pgbouncer_tx pgbouncer_sess node-proliga -d
docker compose up node-proliga -d

curl http://localhost:3030

docker compose down -v

docker compose up -d node-pay-proliga

docker compose up postgres pgrest pgbouncer_tx pgbouncer_sess node-proliga node-pay-proliga appsmith -d
