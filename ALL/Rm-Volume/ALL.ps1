$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker volume ls -q | ForEach {

    $app = $_

    . "$root/ALL/Rm-Volume/Azk.ps1"

}




