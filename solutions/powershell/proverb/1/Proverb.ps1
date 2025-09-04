Function Get-Proverb() {
    [CmdletBinding()]
    Param(
        [string[]]$Data
    )

    (0..$Data.Length | Select-Object -SkipLast 1 | ForEach-Object { $_ -le ($Data.Length - 2) ?
        "For want of a $($Data[$_]) the $($Data[$_ + 1]) was lost." : "And all for the want of a $($Data[0])."}) -join "`r`n"
}