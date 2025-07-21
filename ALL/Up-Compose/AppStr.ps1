Set-Location $root

. "$root/ALL/App/ALL.ps1"

$exec = 'docker-compose --verbose up -d ' + $appsStr
$result = Invoke-Expression $exec
$result

