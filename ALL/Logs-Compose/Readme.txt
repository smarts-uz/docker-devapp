docker-compose logs

docker-compose logs -f
docker-compose logs -f -t
docker-compose logs -f -t --tail="all"

docker-compose logs -f -t --tail="10"

-f, --follow        Follow log output
-t, --timestamps    Show timestamps
--tail="all"        Number of lines to show from the end of the logs
                    for each containe