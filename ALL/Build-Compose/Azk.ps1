Set-Location $root

. "$root/ALL/App/ALL.ps1"

"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

Get-Variable "app"

docker-compose build $app
