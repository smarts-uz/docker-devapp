export INSTANCE_NAME="nginx-bg"
# docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_NAME
172.1

docker container inspect foo