Function Invoke-Panagram() {
    [CmdletBinding()]
    Param(
        [string]$Sentence
    )

    ([Collections.Generic.HashSet[char]]($Sentence.ToLower() -replace "[^a-z]", "")).Count -eq 26
}