# Dedicated to Shree DR.MDD

Function Get-PhoneNumber() {
    [CmdletBinding()]
    Param(
        [string]$Number,
        [switch]$Pretty
    )

    $Cleaned = $Number -replace "[\s().+-]", ""
    $Cleaned = ($Cleaned.StartsWith("1") -and $Cleaned.Length -eq 11) ? $Cleaned.Substring(1) : $Cleaned
    if ($Cleaned.Length -lt 10) { throw "Number can't be fewer than 10 digits" }
    if ($Cleaned.Length -eq 11) { throw "11 digits must start with 1" }
    if ($Cleaned.Length -gt 11) { throw "Number can't be more than 11 digits" }
    if ($Cleaned -match "[a-z]") { throw "Letters not permitted" }
    if ($Cleaned -match "\D") { throw "Punctuations not permitted" }
    if ($Cleaned[0] -in @("0", "1")) { throw "Area code can't start with $($Cleaned[0])" }
    if ($Cleaned[3] -in @("0", "1")) { throw "Exchange code can't start with $($Cleaned[3])" }

    $Pretty ? ($Cleaned -replace "(\d{3})(\d{3})(\d{4})", '($1)-$2-$3') : $Cleaned
}
