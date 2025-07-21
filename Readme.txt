docker-compose up postgres -d
docker-compose up pgrest -d
docker-compose up postgres portainer nginx PostgREST -d

docker-compose rm --force --stop pgrest & docker-compose up pgrest -d