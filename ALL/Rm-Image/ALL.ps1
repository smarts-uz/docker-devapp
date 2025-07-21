$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"


docker-compose down
docker rm -v -f $(docker ps -a -q)

docker volume rm $(docker volume ls -q)
docker image rm 
pause


