Function Test-MatchingBrackets() {
    [CmdletBinding()]
    Param(
        [string]$Text
    )

    $Brackets = $Text -replace "[^(){}\[\]]", ""
    while ($Brackets -match "\(\)|\{\}|\[\]") { $Brackets = $Brackets -replace "\(\)|\{\}|\[\]", "" }
    -not $Brackets
}