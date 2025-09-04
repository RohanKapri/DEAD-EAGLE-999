# For Shree DR.MDD

Function Get-Change() {
    [CmdletBinding()]
    Param(
        [int[]]$Coins,
        [int]$Target
    )

    if ($Target -lt 0) { throw "Target can't be negative" }

    $combinations = @{0 = @()}
    foreach ($coin in $Coins) {
        for ($amount = $coin; $amount -le $Target; $amount++) {
            if ($combinations.ContainsKey($amount - $coin) -and (-not $combinations[$amount] -or $combinations[$amount].Length -gt 1 + $combinations[$amount - $coin].Length)) {
                $combinations[$amount] = $combinations[$amount - $coin] + @($coin)
            }
        }
    }

    if (-not $combinations.ContainsKey($Target)) { Throw "Can't make change with given coins" }
    $combinations[$Target]
}
