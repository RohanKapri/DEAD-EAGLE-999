Function Test-Isbn() {
    [CmdletBinding()]
    Param(
        [string]$Isbn
    )

    $Digits = $Isbn -replace "-", ""
    $Digits.Length -eq 10 -and $Digits -cmatch "^\d{9}[\d|X]" -and (
        (0..9 | ForEach-Object { (10 - $_) * (($Digits[$_] -eq "X") ? 10 : ($Digits[$_] - [char]"0")) } |
        Measure-Object -Sum).Sum % 11 -eq 0
    )
}