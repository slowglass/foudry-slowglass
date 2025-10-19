param(
    [string]$CommitMessage = "Release Version: v{0}"
)

# Get the module data from the module.json file
$modulePath = "module.json"
$module = Get-Content -Raw -Path $modulePath | ConvertFrom-Json

# Get the current version
$currentVersion = $module.version
Write-Host "Current version: $currentVersion"

# 1. Remove -SNAPSHOT from the module version
$releaseVersion = $currentVersion -replace "-SNAPSHOT", ""
Write-Host "Release version: $releaseVersion"

# Update module.json with the release version
$module.version = $releaseVersion
$module.download = "https://github.com/slowglass/foundry-slowglass/releases/download/v$releaseVersion/module.zip"
$module | ConvertTo-Json -Depth 100 | Set-Content -Path $modulePath

# 2. Commit the change with a specific message
$releaseCommitMessage = $CommitMessage -f $releaseVersion
Write-Host "Committing with message: $releaseCommitMessage"
git add $modulePath
git commit -m $releaseCommitMessage

# 3. Add a tag of v<version>
$tagName = "v$releaseVersion"
Write-Host "Adding tag: $tagName"
git tag $tagName

# 4. Push both to GitHub
Write-Host "Pushing changes and tags to GitHub..."
git push
git push --tags

# 5. Increment the patch version by 1 and add back snapshot
$versionParts = $releaseVersion.Split('.')
$major = [int]$versionParts[0]
$minor = [int]$versionParts[1]
$patch = [int]$versionParts[2]

$newPatch = $patch + 1
$nextSnapshotVersion = "$major.$minor.$newPatch-SNAPSHOT"
Write-Host "Next snapshot version: $nextSnapshotVersion"

# Update module.json with the new snapshot version
$module.version = $nextSnapshotVersion
$module.download = "https://github.com/slowglass/foundry-slowglass/releases/download/v$nextSnapshotVersion/module.zip"
$module | ConvertTo-Json -Depth 100 | Set-Content -Path $modulePath

# 6. Commit this new change
$snapshotCommitMessage = "chore: Increment snapshot version to $nextSnapshotVersion"
Write-Host "Committing with message: $snapshotCommitMessage"
git add $modulePath
git commit -m $snapshotCommitMessage

# 7. Push this commit to GitHub
Write-Host "Pushing snapshot version to GitHub..."
git push

Write-Host "Release process completed."
