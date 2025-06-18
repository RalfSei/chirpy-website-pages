# deploy.ps1

# Stelle sicher, dass du im richtigen Projektordner bist
Set-Location -Path "$PSScriptRoot"

Write-Host "🔧 Baue die Jekyll-Seite..."
bundle exec jekyll build

# Wechsle in den _site Ordner
Set-Location -Path ".\_site"

# Git-Repo neu initialisieren oder wiederverwenden
if (-not (Test-Path ".git")) {
    git init
    git remote add origin https://github.com/ralfsei/chirpy-website.git
}

git add .
$commitMessage = "Deploy am $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $commitMessage
git push -f origin main  # ggf. "gh-pages" statt "main", je nach Hosting

# Zurück in den Projektordner
Set-Location -Path "$PSScriptRoot"

Write-Host "✅ Deploy abgeschlossen."
