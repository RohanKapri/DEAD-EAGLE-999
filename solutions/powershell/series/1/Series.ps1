# Dedicated to my Shree DR.MDD

Function Get-Slices() {
    [CmdletBinding()]
    Param(
        [string]$Series,
        [int]$SliceLength
    )

    $TotalLength = $Series.Length
    if ($SliceLength -eq 0) { throw "Slice length cannot be zero." }
    if ($SliceLength -lt 0) { throw "Slice length cannot be negative." }
    if ($TotalLength -eq 0) { throw "Series cannot be empty." }
    if ($SliceLength -gt $TotalLength) { throw "Slice length cannot be greater than series length." }
    0..($TotalLength - $SliceLength) | ForEach-Object { $Series.Substring($_, $SliceLength) }
}
