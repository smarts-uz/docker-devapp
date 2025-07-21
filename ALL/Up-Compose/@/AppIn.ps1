Set-Location $root

# . "$root/ALL/Stop-Compose/Azk.ps1"

$exec = 'docker-compose --verbose up --detach ' + $app
$result = Invoke-Expression $exec
$result


