$FilesToLookAt = Get-ChildItem -Recurse -Filter "*.bash"

$lineCounts = @()
$wordCounts = @()
$charCounts = @()

for ($i = 0; $i -lt $FilesToLookAt.Count; $i++) {
    $content = Get-Content $FilesToLookAt[$i].FullName -Raw
    $lineCount = ($content -split '\n').Count
    $wordCount = ($content -split '\s').Count
    $charCount = $content.Length

    $lineCounts += $lineCount
    $wordCounts += $wordCount
    $charCounts += $charCount
}

# average, min, and max
$averageLineCount = $lineCounts | Measure-Object -Average | Select-Object -ExpandProperty Average
$maxLineCount = $lineCounts | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
$minLineCount = $lineCounts | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum

$averageWordCount = $wordCounts | Measure-Object -Average | Select-Object -ExpandProperty Average
$maxWordCount = $wordCounts | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
$minWordCount = $wordCounts | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum

# output
$outputData = for ($i = 0; $i -lt $FilesToLookAt.Count; $i++) {
    [PSCustomObject]@{
        "Lines" = $lineCounts[$i]
        "Words" = $wordCounts[$i]
        "Characters" = $charCounts[$i]
        "Property" = $FilesToLookAt[$i].Name
    }
}

$outputData | Format-Table -AutoSize

Write-Host "Statistics:"
Write-Host "Average Lines: $averageLineCount"
Write-Host "Max Lines: $maxLineCount"
Write-Host "Min Lines: $minLineCount"
Write-Host "Average Words: $averageWordCount"
Write-Host "Max Words: $maxWordCount"
Write-Host "Min Words: $minWordCount"