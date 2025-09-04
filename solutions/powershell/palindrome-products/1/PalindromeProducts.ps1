# For Shree DR.MDD

Function Get-Products() {
    [CmdletBinding()]
    Param(
        [int]$Min,
        [ValidateScript({$_ -ge $Min})]
        [int]$Max,
        [switch]$Largest
    )

    $RangeStart, $RangeEnd = ($Largest) ? @($Max, $Min) : @($Min, $Max)
    $Palindrome = $null
    $Pairs = @()

    foreach ($first in $RangeStart..$RangeEnd) {
        $updated = $false
        foreach ($second in $first..$RangeEnd) {
            $product = $first * $second
            if (-not $Palindrome -or ($Largest ? ($product -ge $Palindrome) : ($product -le $Palindrome))) {
                $updated = $true
                $strProduct = [string]$product
                if ($strProduct -eq (-join $strProduct[$strProduct.Length..0])) {
                    if ($product -ne $Palindrome) { $Pairs = @() }
                    $Palindrome = $product
                    $Pairs += ($first -lt $second) ? @(,@($first, $second)) : @(,@($second, $first))
                }
            }

            if (-not $updated) { break }
        }
    }

    @{Value = $Palindrome; Products = $Pairs}
}
