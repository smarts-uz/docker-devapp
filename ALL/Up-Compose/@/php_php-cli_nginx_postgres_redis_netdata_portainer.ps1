$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker-compose --verbose up -d php php-cli nginx postgres redis netdata portainer
pause


