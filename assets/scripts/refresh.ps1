# ============================================
Write-Host "============================================="
Write-Host "  🧹 Flutter Git Dependency Auto Refresher"
Write-Host "============================================="

# --- Flutter git cache path ---
$cachePath = "C:\Users\windows\AppData\Local\Pub\Cache\git"
$pkgName = "flutterprovider"

Write-Host "🧽 Checking cache path: $cachePath"
Get-ChildItem -Path $cachePath -Directory

# --- Clean cached repo ---
Write-Host "🧽 Cleaning cached repo: $pkgName ..."
Get-ChildItem -Path $cachePath -Directory | Where-Object { $_.Name -like "$pkgName-*" } | ForEach-Object {
    Write-Host "Deleting: $($_.FullName)"
    Remove-Item -LiteralPath $_.FullName -Recurse -Force
}

# --- Flutter clean ---
Write-Host "🧼 Running flutter clean ..."
# Check if flutter is in PATH
if (Get-Command flutter -ErrorAction SilentlyContinue) {
    flutter clean
} else {
    Write-Host "⚠️ Flutter not found in PATH. Please add Flutter SDK to PATH."
    exit
}

# --- Delete pubspec.lock ---
$pubspecLock = Join-Path -Path (Get-Location) -ChildPath "pubspec.lock"
if (Test-Path $pubspecLock) {
    Write-Host "🗑️  Deleting pubspec.lock ..."
    Remove-Item -LiteralPath $pubspecLock -Force
}

# --- Get latest Git dependency ---
Write-Host "🔄 Running flutter pub get ..."
flutter pub get

Write-Host "✅ Done! flutterprovider dependency refreshed successfully."
Write-Host "Press any key to exit..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
