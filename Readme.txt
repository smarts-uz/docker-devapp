docker-compose up postgres -d
docker-compose up pgrest -d
docker-compose up postgres portainer nginx PostgREST -d

docker-compose up postgres portainer -d
docker-compose up nginx-app -d
docker-compose up nginx-app node-proliga  -d

docker-compose rm --force --stop pgrest & docker-compose up pgrest -d