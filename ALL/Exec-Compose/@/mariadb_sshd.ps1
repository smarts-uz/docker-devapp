$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'mariadb'
$run = '/usr/sbin/sshd -D'

. "$root/ALL/Exec-Compose/Azk.ps1"
