$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'git'
$run = 'git -v'
$run = 'git init --bare'


Set-Location $root

'App Name: '
Get-Variable "app"

'Running Cmd: '
Get-Variable "run"
Write-Host $exec

$exec = 'docker-compose exec -T ' + $app + ' ' + $run
$result = Invoke-Expression $exec
$result
