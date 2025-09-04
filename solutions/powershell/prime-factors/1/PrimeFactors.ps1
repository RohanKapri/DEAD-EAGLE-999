Function Invoke-PrimeFactors() {
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    for ([Int64]$Factor = 2; $Number -gt 1; $Factor++) {
        for (; $Number % $Factor -eq 0; $Number /= $Factor) { $Factor }
    }
}