# For Shree DR.MDD

Function Invoke-KillerSudokuHelper() {
    [CmdletBinding()]
    Param(
        [int]$Sum,
        [int]$Size,
        [int[]]$Exclude
    )

    $options = 1..9 | Where-Object { $_ -le $Sum -and $_ -notin $Exclude }
    Get-Combinations $Sum $Size $options @()
}

Function Get-Combinations([int]$target, [int]$cells, [int[]]$options, [int[]]$path) {
    if ($path.Length -eq $cells -and $target -eq 0) { return @(,$path) }

    for ($idx = 0; $idx -lt $options.Length; $idx++) {
        $val = $options[$idx]
        if ($val -le $target) {
            Get-Combinations ($target - $val) $cells $options[($idx + 1)..$options.Length] ($path + $val)
        }
    }
}
