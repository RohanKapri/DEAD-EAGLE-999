Function Invoke-Isogram() {
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )

    (($Phrase.ToLower() -replace "[^a-z]", "").ToCharArray() | Group-Object | Where-Object { $_.Count -gt 1 }).Length -eq 0
}