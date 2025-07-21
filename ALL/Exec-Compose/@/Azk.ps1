Set-Location $root

'App Name: '
Get-Variable "app"

'Running Cmd: '
Get-Variable "run"

$exec = 'docker-compose exec -T ' + $app + ' ' + $run
$result = Invoke-Expression $exec
$result
