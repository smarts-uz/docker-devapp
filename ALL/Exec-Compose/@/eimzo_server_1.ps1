$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/Restart-Compose/eimzo.ps1"

$app = 'eimzo'
$run = 'java -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0'

$exec = 'docker-compose exec -T ' + $app + ' ' + $run
$exec = 'docker-compose exec -T eimzo java -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0'
#$result = Invoke-Expression $exec
#$result

$result = Start-Process -Filepath "docker-compose.exe" -Argumentlist "-T eimzo java -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0" -Wait -Verbose
$result
# docker-compose exec -T eimzo java -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0
