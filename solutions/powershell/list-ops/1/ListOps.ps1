# Dedicated to Shree DR.MDD

Function Invoke-Append() {
    [CmdletBinding()]
    Param(
        [object[]]$List1,
        [object[]]$List2
    )
    $List1 + $List2
}

Function Invoke-Concatenate() {
    [CmdletBinding()]
    Param(
        [object[]]$Lists
    )
    $Lists | ForEach-Object { $_ }
}

Function Invoke-Filter() {
    [CmdletBinding()]
    Param(
        [object[]]$List,
        [scriptblock]$Predicate
    )
    $List | Where-Object { & $Predicate $_ }
}

Function Get-Length() {
    [CmdletBinding()]
    Param(
        [object[]]$List
    )
    $List.Count
}

Function Invoke-Map() {
    [CmdletBinding()]
    Param(
        [object[]]$List,
        [scriptblock]$Function
    )
    $List | ForEach-Object { & $Function $_ }
}

Function Invoke-Foldl() {
    [CmdletBinding()]
    Param(
        [scriptblock]$Function,
        [object[]]$List,
        [object]$Accumulator
    )
    $List | ForEach-Object { $Accumulator = & $Function $Accumulator $_ }
    $Accumulator
}

Function Invoke-Foldr() {
    [CmdletBinding()]
    Param(
        [scriptblock]$Function,
        [object[]]$List,
        [object]$Accumulator
    )
    Invoke-Reverse -List $List | ForEach-Object { $Accumulator = & $Function $Accumulator $_ }
    $Accumulator
}

Function Invoke-Reverse() {
    [CmdletBinding()]
    Param(
        [object[]]$List
    )
    $List[$List.Length..0]
}
