# deploy.ps1

# In Quellcode-Verzeichnis (nicht _site)
Set-Location -Path "$PSScriptRoot"

Write-Host "🔧 Baue die Seite..."
bundle exec jekyll build --config _config.yml,_config_prod.yml

# Wechsel in _site (die gebaute Webseite)
Set-Location -Path ".\_site"

# Git-Repo initialisieren oder updaten
if (-not (Test-Path ".git")) {
    git init
    git remote add origin https://github.com/ralfsei/chirpy-website-pages.git
}

git add .
$commitMessage = "Deploy am $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $commitMessage
git branch -M main
git push -f origin main

# Zurück ins Quellverzeichnis
Set-Location -Path "$PSScriptRoot"

Write-Host "`n✅ Seite erfolgreich deployed!"
