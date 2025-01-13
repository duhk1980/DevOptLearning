function Backup-Files {
  param (
    [string]$server,
    [string]$source,
    [string]$destination
  )
  $backupPath = Join-Path $destination $(Get-Date -Format "yyyyMMddHHmmss")
  New-Item -ItemType Directory -Path $backupPath -Force
  Copy-Item -Path $source -Destination $backupPath -Recurse -Force
  Write-Output "Backup completed for $source to $backupPath on $server"
}

function Check-WebService {
  param (
    [string]$url,
    [int]$expectedStatusCode = 200
  )
  try {
    $response = Invoke-WebRequest -Uri $url -UseBasicParsing
    return $response.StatusCode -eq $expectedStatusCode
  } catch {
    return $false
  }
}
