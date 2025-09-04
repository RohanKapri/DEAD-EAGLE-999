Function Get-Accumulation() {
    [CmdletBinding()]
    Param(
        [PSObject[]]$List,
        [scriptblock]$Func
    )

    $List | ForEach-Object { & $Func($_) }
}