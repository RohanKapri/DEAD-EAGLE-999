Enum Sublist { EQUAL; SUBLIST; SUPERLIST; UNEQUAL }
Function Invoke-Sublist() {
    [CmdletBinding()]
    Param (
        [object[]]$Data1,
        [object[]]$Data2
    )
    if ([Linq.Enumerable]::SequenceEqual([object[]]$Data1, [object[]]$Data2)) { return [Sublist]::EQUAL }
    if ($Data1.Length -eq 0 -or (Test-Sublist $Data1 $Data2)) { return [Sublist]::SUBLIST }
    if ($Data2.Length -eq 0 -or (Test-Sublist $Data2 $Data1)) { return [Sublist]::SUPERLIST }
    return [Sublist]::UNEQUAL
}

function Test-Sublist([object[]]$Data1, [object[]]$Data2) {
    $Result = $false
    if ($Data1.Length -lt $Data2.Length) {
        for ($X = 0; -not $Result -and $X -le ($Data2.Length - $Data1.Length); $X++) { 
            $Result = [Linq.Enumerable]::SequenceEqual([object[]]$Data1, [object[]]$Data2[$X..($X + $Data1.Length - 1)])
        }
    }
    $Result
}