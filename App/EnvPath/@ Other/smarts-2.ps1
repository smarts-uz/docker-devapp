$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

Write-Output "Root: $( $root )"
Write-Output "Args: $( $args )"
Write-Output "Args Count: $( $args.count )"
Write-Output  "$IsLinux"

if ($args.count -lt 2)
{
    Write-Output 'Incorrect Argument count'
    exit
}

$folder = $args[0]
$file = $args[1]

$run = New-Object System.Collections.ArrayList(,$args)

$run.RemoveAt(0)
$run.RemoveAt(0)

Get-Variable "run"

If ($IsLinux)
{
    . "/var/app/ALL/ALL/$( $folder )/$( $file ).ps1" $run
    
    #   pwsh -File "/var/app/ALL/ALL/$($folder)/$($file).ps1" $run -All
}
else
{

    . "D:\Develop\Projects\docker\ALL\ALL\$( $folder )\$( $file ).ps1" $run
    # Powershell.exe -ExecutionPolicy ByPass -File "D:\Develop\Projects\docker\ALL\ALL\$($folder)\$($file).ps1" $run
}

$result



# smarts ALL-Nc portainer
# smarts Stop-Compose portainer
# smarts Rm-Volume portainer
# smarts Rm-Compose-V portainer
# smarts ALL-Nc AZK portainer
