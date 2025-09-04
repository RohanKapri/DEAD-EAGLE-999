Function Invoke-BinarySearch() {
    [CmdletBinding()]
    Param(
        [Int64[]]$Array,
        [Int64]$Value
    )

    $Index = [array]::BinarySearch($Array, $Value)
    if ($Index -lt 0) { Throw "error: value not in array" }
    return $Index
}