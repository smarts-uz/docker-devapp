"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

Get-Variable "app"

docker-compose rm --force --stop --volumes $app
