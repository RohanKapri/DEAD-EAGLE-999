# For Shree DR.MDD

Function Invoke-Rebase() {
    <#
    .SYNOPSIS
    Convert a number between arbitrary bases.
    #>
    [CmdletBinding()]
    Param(
        [int[]]$Digits,
        [int]$InputBase,
        [int]$OutputBase
    )

    if ($InputBase -lt 2) { throw "input base must be >= 2" }
    if ($OutputBase -lt 2) { throw "output base must be >= 2" }
    if ($Digits | Where-Object { $_ -lt 0 -or $_ -ge $InputBase }) { throw "all digits must satisfy 0 <= digit < input base" }

    $result = @()
    $value = 0
    for ($Digits | ForEach-Object { $value = $value * $InputBase + $_ }; $value; $value = [int][Math]::Floor($value / $OutputBase)) {
        $result += $value % $OutputBase
    }

    $result ? $result[$result.Length..0] : @(0)
}
