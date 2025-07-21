$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Gits.ps1"

ForEach ($appPath In $gits)
{
    "   "
    "Start Chmod: " + $appPath

    $bootstrapPath = $appPath + '/bootstrap'
    $storagePath = $appPath + '/storage'

    if (Test-Path -Path "$bootstrapPath")
    {
        chmod 777 -R $bootstrapPath/* --verbose --changes
    }

    if (Test-Path -Path "$storagePath")
    {
        chmod 777 -R $storagePath/* --verbose --changes
    }

}





