$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker-compose down
docker rm -v asrorz_nginx_1_asrorz_php_1_asrorz_docker-in-docker_1_asrorz_redis_1_asrorz_portainer_1_asrorz_mariadb_1_asrorz_mysql_1_asrorz_postgres_1_asrorz_netdata_1


