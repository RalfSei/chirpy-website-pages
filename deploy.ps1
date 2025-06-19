# deploy.ps1

# Stelle sicher, dass du im Projektordner (chirpy-quellcode) bist
Set-Location -Path "$PSScriptRoot"

Write-Host "🔧 Baue die Jekyll-Seite für Produktion..."

# Baue mit Produktionskonfiguration
bundle exec jekyll build --config _config.yml,_config_prod.yml

# Wechsle in den _site-Ordner (fertige Seite)
Set-Location -Path ".\_site"

# Initialisiere Git, falls noch nicht geschehen
if (-not (Test-Path ".git")) {
    git init
    git remote add origin https://github.com/RalfSei/chirpy-website-pages.git
}

# Optional: Korrigiere den Remote-Link für Sicherheit
git remote set-url origin https://github.com/RalfSei/chirpy-website-pages.git

# Push-Vorgang
git add .
$commitMessage = "🚀 Deploy am $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $commitMessage
git branch -M main
git push -f origin main

# Zurück in den Projektordner
Set-Location -Path "$PSScriptRoot"

Write-Host "`n✅ Quellcode gebaut und Website erfolgreich deployed nach chirpy-website-pages!"

