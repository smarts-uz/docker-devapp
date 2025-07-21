$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker ps -a -q | ForEach {

    $app = $_

    . "$root/ALL/Stop/Azk.ps1"

}


