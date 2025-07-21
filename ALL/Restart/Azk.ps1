
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

Get-Variable "app"

docker restart $app

. "$root/ALL/Exec_Sshd/Azk.ps1"


