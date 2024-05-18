param(
    [string]$PATH_TO_ZROK="C:\path\to\zrok\zrok.exe",
    [string]$FOUNDRY_SERVER_IP = "127.0.0.1",
    [string]$FOUNDRY_SERVER_PORT = "30000",
	[switch]$PUBLIC = $false,
	[string]$RESERVED = "true",
	[string]$SHARE_NAME = "foundryvtt"
)

try {
  $IS_RESERVED = [System.Convert]::ToBoolean($RESERVED) 
} catch [FormatException] {
  $IS_RESERVED = $false
}

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

if (Test-Path "$env:USERPROFILE\.zrok\environment.json" -PathType Leaf) {
} else {
    Write-Host -ForegroundColor Red "zrok not enabled! enable zrok before continuing!"
    return
}

# Convert JSON content to a PowerShell object
$jsonObject = Get-Content -Path "$env:USERPROFILE\.zrok\environment.json" -Raw | ConvertFrom-Json

# get the name of your identity
$zid = $jsonObject.ziti_identity

# Strip anything not alphanumeric
$RESERVED_SHARE = (($zid -replace '[^a-zA-Z0-9]', '') + $SHARE_NAME).ToLower()

# Convert JSON to PowerShell object
$jsonObject = Invoke-Expression "$PATH_TO_ZROK overview" | ConvertFrom-Json

$targetEnvironment = $jsonObject.environments | Where-Object { $_.environment.zId -eq $zid }

if ($IS_RESERVED) {	
	if ($targetEnvironment) {
		$shares = $targetEnvironment.shares | Where-Object { $_.token -eq $RESERVED_SHARE }

		if ($shares) {
			Write-Host -ForegroundColor Yellow "Found share with token $RESERVED_SHARE in environment $zid. Releasing share..."
			& "$PATH_TO_ZROK" release $RESERVED_SHARE
		}
	}
	if ($PUBLIC) {
		Write-Host -ForegroundColor Green "Reserving public share: $RESERVED_SHARE"
		& "$PATH_TO_ZROK" reserve public "${FOUNDRY_SERVER_IP}:${FOUNDRY_SERVER_PORT}" --unique-name "$RESERVED_SHARE"
	} else {
		Write-Host -ForegroundColor Green "Reserving private share: $RESERVED_SHARE"
		& "$PATH_TO_ZROK" reserve private "${FOUNDRY_SERVER_IP}:${FOUNDRY_SERVER_PORT}" --backend-mode tcpTunnel --unique-name "$RESERVED_SHARE"
	}
} else {
	Write-Host -ForegroundColor Green "Using ephemeral share. This share changes every time!"
}

$OriginalProgressPreference = $Global:ProgressPreference
$Global:ProgressPreference = 'SilentlyContinue'
while (-not (Test-NetConnection -ComputerName $FOUNDRY_SERVER_IP -Port $FOUNDRY_SERVER_PORT -InformationLevel Quiet)) {
    Write-Host "Waiting for port $FOUNDRY_SERVER_PORT to respond..."
	Write-Host "   If this loops forever, your Foundry server is not running on this port"
	Write-Host "   or it's being blocked by your firewall or something like that!"
    Start-Sleep -Seconds 5
}
$Global:ProgressPreference = $OriginalProgressPreference

Write-Host "Port $FOUNDRY_SERVER_PORT is now open. Starting zrok share"

if ($IS_RESERVED) {
	& "$PATH_TO_ZROK" share reserved $RESERVED_SHARE
} else {
	$PUBLIC_OR_PRIVATE="private"
	$BACKEND_MODE="--backend-mode tcpTunnel"
	if ($PUBLIC) {
		$PUBLIC_OR_PRIVATE="public"
		$BACKEND_MODE=""
	}
	& "$PATH_TO_ZROK" share $PUBLIC_OR_PRIVATE "${FOUNDRY_SERVER_IP}:${FOUNDRY_SERVER_PORT}" 
}


Write-Host ""
Write-Host ""
Write-Host "To stop, click in the zrok window, press 'ctrl-c', and wait for the window to disappear"
Write-Host ""
Write-Host ""