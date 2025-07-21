$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'eimzo'
$run = 'java -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0'

. "$root/ALL/Exec-Compose/Azk.ps1"
