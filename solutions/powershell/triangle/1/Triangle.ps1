Enum Triangle { EQUILATERAL = 1; ISOSCELES = 2; SCALENE = 3 }

Function Get-Triangle() {
    
    [CmdletBinding()]
    Param (
        [double[]]$Sides
    )
    $A, $B, $C = $Sides | Sort-Object
    if ($A -le 0) { throw "All side lengths must be positive." }
    if ($A + $B -lt $C) { throw "Side lengths violate triangle inequality." }
    [Triangle].GetEnumName(($Sides | Group-Object).Length)
}