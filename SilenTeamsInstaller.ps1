$TeamsCurrentPath ="$env:LOCALAPPDATA\Microsoft\Teams\current"


Write-Output "Welcome to the SilenTeams installer"
Write-Output "Please make sure to exit teams before running this"

if(Test-Path $TeamsCurrentPath) {
    Write-Output "Downloading fake dbghelp.dll"
    Invoke-WebRequest -URI "https://github.com/Hypfer/SilenTeams/releases/download/v1.0.0/dbghelp.dll" -OutFile $TeamsCurrentPath"\dbghelp.dll"
    Write-Output "Downloaded fake dbghelp.dll"
    Write-Output "Copying real dbghelp.dll"
    Copy-Item "C:\Windows\System32\dbghelp.dll" -Destination $TeamsCurrentPath"\dbghelp_orig.dll"
    Write-Output "Copied real dbghelp.dll"

    Write-Output "Enjoy not being annoyed by Teams anymore"
    Write-Output "Please note that you will need to rerun this script every time Teams decides to update itself"
} else {
    Write-Output "Couldn't find Teams install folder at "$TeamsCurrentPath
}
