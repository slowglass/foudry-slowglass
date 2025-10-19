# Get the module data from the module.json file
$module = Get-Content -Raw -Path "module.json" | ConvertFrom-Json

# Get the module id and version
$id = $module.id
$version = $module.version

# Create the zip file name
$zipFileName = "$id-$version.zip"

# Get the list of files to include in the zip file
$files = Get-ChildItem -Path "." -Recurse -Exclude ".git", "*.zip", "build.ps1"

# Create the zip file
Compress-Archive -Path $files.FullName -DestinationPath $zipFileName -Force

Write-Host "Module zip file created: $zipFileName"
