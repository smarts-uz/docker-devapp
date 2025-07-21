$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/List.ps1"


$apps | ForEach {
    $app = $_;
    . "$root/ALL/Exec_Sshd/Azk.ps1"
}

netstat -nplt


