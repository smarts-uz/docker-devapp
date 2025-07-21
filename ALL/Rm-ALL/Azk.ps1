$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

Get-Variable "app"

. "$root/ALL/App/App.ps1"

. "$root/ALL/Stop/Azk.ps1"
. "$root/ALL/Rm/Azk.ps1"
. "$root/ALL/Rmi/Azk.ps1"
. "$root/ALL/Rm-Volume/Azk.ps1"

# Start-Sleep -Seconds 4




