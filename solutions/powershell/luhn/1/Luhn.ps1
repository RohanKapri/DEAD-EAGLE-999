Function Test-Luhn() {
    [CmdletBinding()]
    Param(
        [string]$Value
    )

    $Value = $Value -replace " ", ""
    if ($Value.Length -lt 2 -or $Value -match "\D") { return $false }

    $D = ($Value.Length - 1)..0 | ForEach-Object { $Value[$_] - [char]"0" }
    (0..($D.Length - 1) | ForEach-Object { ($_ % 2) ? 2 * ($D[$_] % 5) + [Math]::floor($D[$_] / 5) : $D[$_] } |
        Measure-Object -Sum).Sum % 10 -eq 0
}