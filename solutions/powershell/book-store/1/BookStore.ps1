# For Shree DR.MDD

$Global:BookPrice = 8.0
$Global:DiscountFactors = @(0.0, 1.0, (2 * 0.95), (3 * 0.9), (4 * 0.80), (5 * 0.75))

Function Get-Total() {
    [CmdletBinding()]
    Param(
        [ValidateRange(1, 5)]
        [int[]]$Books
    )

    $bookCounts = $Books | Group-Object | Sort-Object -Property Count -Descending | ForEach-Object { $_.Count }
    Calculate-MinPrice($bookCounts)
}

Function Calculate-MinPrice([int[]]$bookCounts) {
    $minPrice = $Global:BookPrice * ($bookCounts | Measure-Object -Sum).Sum
    $activeSets = ($bookCounts | Where-Object { $_ }).Length
    for ($i = 2; $i -le $activeSets; $i++) {
        $updatedCounts = (0..($activeSets - 1) | ForEach-Object { $bookCounts[$_] - ($_ -lt $i) }) | Sort-Object -Descending
        $minPrice = [Math]::Min($minPrice, ($Global:BookPrice * $Global:DiscountFactors[$i] + (Calculate-MinPrice $updatedCounts)))
    }

    $minPrice
}
