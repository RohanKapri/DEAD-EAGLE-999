Function Invoke-PerfectNumbers() {
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    if ($Number -le 0) { throw "error: Classification is only possible for positive integers." }
    $S = (1..([Math]::Sqrt($Number)) | Where-Object { $Number % $_ -eq 0 } | ForEach-Object { $_; $Number / $_ } |
        Select-Object -unique | Measure-Object -sum).sum - $Number
    @("perfect", "deficient", "abundant")[($S -lt $Number) + 2 * ($S -gt $Number)]
}