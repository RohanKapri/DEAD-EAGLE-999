# Dedicated to my Shree DR.MDD

Function Get-SquareOfSum() {
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    $Number * $Number * ($Number + 1) * ($Number + 1) / 4
}

Function Get-SumOfSquares() {
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    $Number * ($Number + 1) * (2 * $Number + 1) / 6
}

Function Get-DifferenceOfSquares() {
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    (Get-SquareOfSum -Number $Number) - (Get-SumOfSquares -Number $Number)
}
