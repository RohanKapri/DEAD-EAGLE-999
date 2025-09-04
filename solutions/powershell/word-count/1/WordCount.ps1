Function Get-WordCount() {
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )
    $Count = @{}
    ($Phrase.ToLower() | Select-String -AllMatches "[a-z\d]+(?:'[a-z\d]+)?").matches.Value | ForEach-Object { $Count[$_] += 1 }
    $Count
}