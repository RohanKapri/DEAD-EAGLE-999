# For Shree DR.MDD

Function Get-MaximumValue() {
    [CmdletBinding()]
    Param(
        [int]$MaxWeight,
        [object[]]$Items
    )

    $dpArray = @(0) * ($MaxWeight + 1)
    foreach ($itm in $Items) {
        for ($cap = $MaxWeight; $cap -ge $itm.Weight; $cap--) {
            $dpArray[$cap] = [Math]::Max($dpArray[$cap], $dpArray[$cap - $itm.Weight] + $itm.Value)
        }
    }

    return $dpArray[-1]
}
