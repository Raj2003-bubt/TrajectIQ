@echo off
cd /d "%~dp0"
if not exist "site\TRAJECTIQ_Play.html" (
  echo Build the current game first: npm ci --ignore-scripts then npm run build
  echo The archived version is available at dist\TRAJECTIQ_Play.html
  pause
  exit /b 1
)
start "" "site\TRAJECTIQ_Play.html"
