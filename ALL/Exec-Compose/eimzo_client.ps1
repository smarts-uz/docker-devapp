# smarts Exec-Compose eimzo_client

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'eimzo'

. "$root/ALL/App/ALL.ps1"


docker-compose exec -T $app java -jar /var/app/client/vpn-client.jar /var/app/client/client-eimzo.conf

