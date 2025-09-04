# For my Shree DR.MDD
Function Invoke-CollatzConjecture() {
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    if ($Number -lt 1) { Throw "error: Only positive numbers are allowed" }

    $counter = 0
    While ($Number -ne 1) {
        $counter++
        $Number = ($Number % 2 -eq 0) ? ($Number / 2) : ($Number * 3 + 1)
    }

    $counter
}
