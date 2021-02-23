$TeamsCurrentPath ="$env:LOCALAPPDATA\Microsoft\Teams\current"


Write-Output "Welcome to the SilenTeams installer"
Write-Output "Please make sure to exit teams before running this"

if(Test-Path $TeamsCurrentPath) {
    Write-Output "Downloading fake dbghelp.dll"
    $latestRelease = Invoke-WebRequest https://api.github.com/repos/Hypfer/SilenTeams/releases/latest -UseBasicParsing -Headers @{"Accept"="application/json"}
    $json = $latestRelease.Content | ConvertFrom-Json
    Invoke-WebRequest $json.assets.browser_download_url -UseBasicParsing -OutFile $(Join-Path "$TeamsCurrentPath" $json.assets.name)
    
    Write-Output "Downloaded fake dbghelp.dll"
    Write-Output "Copying real dbghelp.dll"
    Copy-Item "C:\Windows\System32\dbghelp.dll" $(Join-Path "$TeamsCurrentPath" "dbghelp_orig.dll") -Force
    Write-Output "Copied real dbghelp.dll"

    Write-Output "Enjoy not being annoyed by Teams anymore"
    Write-Output "Please note that you will need to rerun this script every time Teams decides to update itself"
} else {
    Write-Output "Couldn't find Teams install folder at "$TeamsCurrentPath
}