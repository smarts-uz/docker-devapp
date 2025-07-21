

"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

Get-Variable "app"

docker rm --force --volumes $app
