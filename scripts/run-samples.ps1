# Try whatever runtimes you have installed — skips missing tools gracefully.
$ErrorActionPreference = "Continue"
$Root = Split-Path $PSScriptRoot -Parent
Set-Location $Root

function Try-Run($name, $scriptBlock) {
    Write-Host "`n=== $name ===" -ForegroundColor Cyan
    try { & $scriptBlock } catch { Write-Host "(skipped: $($_.Exception.Message))" -ForegroundColor DarkGray }
}

Try-Run "C++ (build in Visual Studio, then run .exe)" { Write-Host "Press F5 in VS on 'the most diversity' project" }
Try-Run "Python" { python languages/python/hello.py }
Try-Run "Node" { node languages/javascript/hello.js }
Try-Run "Ruby" { ruby languages/ruby/hello.rb }
Try-Run "Go" { go run languages/go/hello.go }
Try-Run "Rust" { rustc languages/rust/hello.rs -o $env:TEMP\diversity-rust.exe; & $env:TEMP\diversity-rust.exe }
Try-Run "PHP" { php languages/php/hello.php }
Try-Run "Lua" { lua languages/lua/hello.lua }
Try-Run "Perl" { perl languages/perl/hello.pl }
Try-Run "PowerShell" { powershell -NoProfile -File languages/powershell/hello.ps1 }
Try-Run "Bash (Git Bash/WSL)" { bash languages/bash/hello.sh }

Write-Host "`nDone. See README.md for the full museum map." -ForegroundColor Green
