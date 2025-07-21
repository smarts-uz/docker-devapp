$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker images -a -q | ForEach {

    $app = $_

    . "$root/ALL/Rmi/Azk.ps1"

}


