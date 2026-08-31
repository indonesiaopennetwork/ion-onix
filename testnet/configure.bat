@echo off
setlocal

rem Always work relative to the location of configure.bat.
set "SCRIPT_DIR=%~dp0"
set "SETTINGS_FILE=%SCRIPT_DIR%settings.env"
set "CONFIG_DIR=%SCRIPT_DIR%config"
set "POSTMAN_DIR=%SCRIPT_DIR%postman"

if not exist "%SETTINGS_FILE%" (
    echo Error: settings.env not found: %SETTINGS_FILE% 1>&2
    exit /b 1
)

if not exist "%CONFIG_DIR%\" (
    echo Error: config directory not found: %CONFIG_DIR% 1>&2
    exit /b 1
)

echo Applying settings from: %SETTINGS_FILE%

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ErrorActionPreference = 'Stop';" ^
  "$settingsFile = $env:SETTINGS_FILE;" ^
  "$configDir = $env:CONFIG_DIR;" ^
  "$postmanDir = $env:POSTMAN_DIR;" ^
  "" ^
  "$settings = [ordered]@{};" ^
  "foreach ($line in [IO.File]::ReadAllLines($settingsFile)) {" ^
  "  if ([string]::IsNullOrWhiteSpace($line)) { continue };" ^
  "  if ($line -match '^\s*#') { continue };" ^
  "  $pos = $line.IndexOf('=');" ^
  "  if ($pos -lt 0) {" ^
  "    [Console]::Error.WriteLine('Warning: ignoring invalid settings.env line: ' + $line);" ^
  "    continue;" ^
  "  };" ^
  "  $key = $line.Substring(0, $pos).Trim();" ^
  "  $value = $line.Substring($pos + 1);" ^
  "  if ($key -notmatch '^[A-Za-z_][A-Za-z0-9_]*$') {" ^
  "    [Console]::Error.WriteLine('Warning: ignoring invalid key: ' + $key);" ^
  "    continue;" ^
  "  };" ^
  "  $settings[$key] = $value;" ^
  "};" ^
  "" ^
  "if ($settings.Contains('NGROK_DEV_DOMAIN') -and $settings['NGROK_DEV_DOMAIN']) {" ^
  "  $settings['BASE_URL'] = 'https://' + $settings['NGROK_DEV_DOMAIN'];" ^
  "} else {" ^
  "  $settings['BASE_URL'] = 'http://host.docker.internal:9000';" ^
  "};" ^
  "" ^
  "function Process-File([string] $file) {" ^
  "  $content = [IO.File]::ReadAllText($file);" ^
  "  foreach ($entry in $settings.GetEnumerator()) {" ^
  "    $content = $content.Replace('{{' + $entry.Key + '}}', [string]$entry.Value);" ^
  "  };" ^
  "  [IO.File]::WriteAllText($file, $content);" ^
  "  Write-Host ('Processed: ' + $file);" ^
  "};" ^
  "" ^
  "Get-ChildItem -LiteralPath $configDir -Recurse -File |" ^
  "  Where-Object { $_.Extension -in '.yaml', '.yml', '.json' } |" ^
  "  ForEach-Object { Process-File $_.FullName };" ^
  "" ^
  "if (Test-Path -LiteralPath $postmanDir -PathType Container) {" ^
  "  Get-ChildItem -LiteralPath $postmanDir -Recurse -File -Filter '*postman_environment.json' |" ^
  "    ForEach-Object { Process-File $_.FullName };" ^
  "} else {" ^
  "  [Console]::Error.WriteLine('Warning: postman directory not found: ' + $postmanDir);" ^
  "}"

if errorlevel 1 (
    echo Error: configuration failed. 1>&2
    exit /b 1
)

echo Configuration complete.
exit /b 0