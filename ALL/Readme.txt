chcp 65001

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

 

docker-compose --verbose up nginx mysql postgres redis
docker-compose build --parallel nginx mysql postgres redis

docker-compose kill -s SIGINT
docker-compose port
docker-compose rm
docker-compose start

docker-compose start
docker-compose stop

php-fpm nginx mariadb postgres redis netdata portainer







ALL
ALL-Nc
Build-Compose
Build-Compose-Nc
Logs-Compose
Restart-Compose
Top-Compose
Exec-Compose
Exec, Sshd
Prune-Container
Prune-Image
Prune-Network
Prune-Volume
Ps
Ps-Compose
Rm
Rm-ALL
Rm-Compose
Rm-Compose-V
Rmi
Rm-Image
Rm-Volume
Stop
Stop-Compose
Stop-Compose-Down
Stop-Kill-Compose, SIGINT
Up-ALL
Up-Compose
