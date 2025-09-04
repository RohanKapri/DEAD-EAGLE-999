Function Get-LargestSeriesProduct() {
    [CmdletBinding()]
    Param(
        [string]$Digits,
        [int]$Span
    )

    $len = $Digits.Length
    if ($Span -gt $len) { throw "Error: span must be smaller than string length" }
    if ($Digits -match '\D') { throw "Error: digits input must only contain digits" }
    if ($Span -lt 0) { throw "Error: span must not be negative" }

    (@(for ($i = 0; $i -le ($len - $Span); $i++) {
        $product = 1
        $Digits.Substring($i, $Span).ToCharArray() | ForEach-Object { $product *= $_ - [char]'0' }
        $product
    }) | Measure-Object -Maximum).Maximum
}