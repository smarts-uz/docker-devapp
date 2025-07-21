$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker-compose down
docker volume rm postgres

Start-Sleep -Seconds 4
