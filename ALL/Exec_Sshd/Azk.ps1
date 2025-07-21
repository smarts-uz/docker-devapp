
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"
. "$root/ALL/App/ALL.ps1"

Get-Variable "app"

docker exec -i $app /usr/sbin/sshd
