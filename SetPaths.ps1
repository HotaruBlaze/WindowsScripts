# Load Initial "Plugins"
. "./vars.ps1"

Function SetPaths {
    . "./Powershell-Plugins/KnownFolderPath.ps1"
    $FolderPaths.PSBase.Keys | ForEach-Object {
        $path = ($FolderDrive + $FolderPaths[$PSItem])
        $folder = $PSItem
        Write-Host "Setting `"$folder`" to `"$path`""-ForegroundColor Green
        Set-KnownFolderPath -KnownFolder $folder -Path $Path | Out-Null
    }
    Write-Host "Restarting Explorer"-ForegroundColor Blue
    stop-process -Name "explorer"
}
function Main {
    $PSVersion = $PSVersionTable.PSVersion
    $PSVersion = $PSVersion.Major
    Write-Host "Using Powershell v$PSVersion"-ForegroundColor DarkGray
    SetPaths
}

Main