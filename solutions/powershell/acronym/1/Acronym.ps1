Function Get-Acronym() {
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )
    ($Phrase -creplace "([A-Za-z])[A-Za-z']+", "`$1" -creplace "[^A-Za-z]", "").ToUpper()
}