param(
    [string]$PATH_TO_ZROK="C:\path\to\zrok\zrok.exe",
    [string]$FOUNDRY_SERVER_IP = "127.0.0.1",
    [string]$FOUNDRY_SERVER_PORT = "30000"
)

$command = Get-Command zrok -ErrorAction SilentlyContinue
if (Get-Command zrok -ErrorAction SilentlyContinue) {
    Write-Host -ForegroundColor Green "zrok is found on the PATH at: $($command.Path)"
	$PATH_TO_ZROK=$($command.Path)
}


do {
    if (Test-Path $PATH_TO_ZROK -PathType Leaf) {
        break
    } else {
        Write-Host -ForegroundColor Red "==== PATH_TO_ZROK incorrect! ===="
        Write-Host -ForegroundColor Red "(update PATH_TO_ZROK in this script to avoid seeing this message)"
        
        $PATH_TO_ZROK = Read-Host "Enter the correct path"
    }
} while ($true)

$PRIVATE_ACCESS_TOKEN = Read-Host "Enter the private access token"

& "$PATH_TO_ZROK" access private $PRIVATE_ACCESS_TOKEN --bind ${FOUNDRY_SERVER_IP}:${FOUNDRY_SERVER_PORT}