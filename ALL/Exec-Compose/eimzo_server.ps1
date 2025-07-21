$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'eimzo'

. "$root/ALL/App/ALL.ps1"

docker-compose exec -T $app java -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0
