$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

 
docker-compose build --no-cache nginx mariadb postgres redis netdata
