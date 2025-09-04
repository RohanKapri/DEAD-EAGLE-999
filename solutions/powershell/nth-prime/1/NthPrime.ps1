Function Get-NthPrime() {
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    if ($Number -lt 1) { throw "error: there is no zeroth prime" }
    $Prime = 1
    for ($N = 1; $N -le $Number; $N++) {
        for ($Prime++; -not (Test-IsPrime $Prime); $Prime++) {}
    }

    $Prime
}

function Test-IsPrime([int]$Prime) {
    $IsPrime = $true
    for ($K = 2; $K * $K -le $Prime -and ($IsPrime = $Prime % $K -ne 0); $K++) {}
    $IsPrime
}