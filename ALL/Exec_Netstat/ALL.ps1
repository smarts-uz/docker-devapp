$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/List.ps1"


Get-Variable "apps"


Get-Variable "appsStr"


$apps | ForEach {

    $app = $_;

    . "$root/ALL/Exec_Netstat/Azk.ps1"

}

netstat -nplt


