# Dedicated to Shree DR.MDD

$Global:Functions = @{
    "plus" = { Param([int]$Left, [int]$Right) $Left + $Right };
    "minus" = { Param([int]$Left, [int]$Right) $Left - $Right };
    "multiplied" = { Param([int]$Left, [int]$Right) $Left * $Right };
    "divided" = { Param([int]$Left, [int]$Right) [Math]::Floor($Left / $Right) }
}

Function Get-Answer() {
    [CmdletBinding()]
    Param(
        [string]$Question
    )

    $Words = $Question.TrimStart("What is").TrimEnd("?") -replace "by", "" -split " " -ne ""
    $ValidKeywords = ($Global:Functions.Keys -join "|") + "|\-?\d+"
    if (($Words | Where-Object { $_ -notmatch $ValidKeywords }).Length) { throw "Unknown operation" }
    try {
        $Result = [int]::Parse($Words[0])
        for ($Index = 1; $Index -lt $Words.Length; $Index += 2) {
            $Result = & $Global:Functions[$Words[$Index]] $Result ([int]::Parse($Words[$Index + 1]))
        }
    } catch { throw "Syntax error" }

    $Result
}
