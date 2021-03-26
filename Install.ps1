# Load Initial "Plugins"
. "./Powershell-Plugins/Test-CommandExists.ps1"
. "./vars.ps1"

$isWingetInstalled = Test-CommandExists winget
Function doWinget {
    if ($isWingetInstalled -eq $true) {
        Write-Host "Winget is installed."-ForegroundColor Green; Write-Host "Getting version..."-ForegroundColor DarkGray
        [array] $wingetVersion = @(winget --version)
        Write-Host "Using winget: $wingetVersion"-ForegroundColor DarkGray
        $installApplications | ForEach-Object {
            Write-Host "Installing $PSItem" -ForegroundColor DarkGray
            winget install $PSItem | Out-Null
            Write-Host "Done Installng $PSItem"-ForegroundColor Green
        }
    }
    else {
        Write-Host "Winget is not installed, Unable to install..."-ForegroundColor Red
        Write-Host "https://github.com/microsoft/winget-cli/releases/tag/v-0.2.10771-preview"-ForegroundColor DarkGray
        Exit-PSSession
    }
}

function Main {
    $PSVersion = $PSVersionTable.PSVersion
    $PSVersion = $PSVersion.Major
    Write-Host "Using Powershell v$PSVersion"-ForegroundColor DarkGray
    doWinget

}

Main