# smarts Exec eimzo_client

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'eimzo'

docker exec -i $app java -jar /var/app/client/vpn-client.jar /var/app/client/client-eimzo.conf
