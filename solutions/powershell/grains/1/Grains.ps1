# Dedicated to my Shree DR.MDD

Function Get-GrainSquare() {
    [CmdletBinding()]
    Param(
        [BigInt]$Number
    )

    if ($Number -lt 1 -or $Number -gt 64) { throw "square must be between 1 and 64" }
    [BigInt]1 -shl ($Number - 1)
}

Function Get-GrainTotal() {
    ([BigInt]1 -shl 64) - 1
}
