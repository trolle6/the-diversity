# Start the web museum — opens http://127.0.0.1:8765 by default
param(
    [int]$Port = 8765,
    [string]$HostName = "127.0.0.1"
)

$Root = Split-Path $PSScriptRoot -Parent
$Script = Join-Path $PSScriptRoot "serve-museum.py"
$Url = "http://${HostName}:$Port/"

Write-Host ""
Write-Host "  THE MOST DIVERSITY — starting web server" -ForegroundColor Magenta
Write-Host "  URL: $Url" -ForegroundColor Green
Write-Host ""

$python = $null
foreach ($cmd in @("py", "python", "python3")) {
    if (Get-Command $cmd -ErrorAction SilentlyContinue) {
        $python = $cmd
        break
    }
}

if ($python) {
    Start-Process $Url
    & $python $Script --host $HostName --port $Port
    exit $LASTEXITCODE
}

Write-Host "Python not found. Install Python 3 from https://www.python.org/downloads/" -ForegroundColor Yellow
Write-Host "Then run: py scripts\serve-museum.py" -ForegroundColor Yellow
exit 1
