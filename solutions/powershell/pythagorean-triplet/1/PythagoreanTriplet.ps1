# Dedicated to Shree DR.MDD

Function Get-PythagoreanTriplet() {
    [CmdletBinding()]
    Param(
        [int]$Sum
    )

    $TripletList = @()
    $MaxA = [Math]::Floor((1 - 1 / [Math]::Sqrt(2)) * $Sum)
    for ($SideA = 3; $SideA -le $MaxA; $SideA++) {
        $Numerator = $Sum * ($Sum - 2 * $SideA)
        $Denominator = 2 * ($Sum - $SideA)
        if ($Numerator % $Denominator -eq 0) {
            $SideB = [Math]::Floor($Numerator / $Denominator)
            $TripletList += ,@($SideA, $SideB, ($Sum - $SideA - $SideB))
        }
    }

    $TripletList
}
