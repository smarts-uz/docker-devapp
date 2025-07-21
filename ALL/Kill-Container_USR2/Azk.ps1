Set-Location $root



"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

Get-Variable "app"

docker container kill --signal USR2 $app


