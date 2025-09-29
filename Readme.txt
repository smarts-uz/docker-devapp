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

docker compose down -v nginx-app

docker compose up -d node-pay-proliga

docker compose up -d postgres pgrest pgbouncer_tx pgbouncer_sess node-proliga node-pay-proliga appsmith nginx-app

docker compose up -d nginx-app node-proliga

docker compose up -d node-lesaapp-api

docker compose up -d nginx-app

docker compose down -v nginx-app node-lesaapp-api


docker compose up -d nginx-app node-lesaapp-api

docker compose up -d postgres-dev

