$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker ps -a -f status=exited -q | ForEach {

    $app = $_

    . "$root/ALL/Rm-V/Azk.ps1"

}




