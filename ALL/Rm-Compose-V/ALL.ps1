$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker-compose ps --services | ForEach {

    $app = $_

    . "$root/ALL/Rm-Compose-V/Azk.ps1"

}




