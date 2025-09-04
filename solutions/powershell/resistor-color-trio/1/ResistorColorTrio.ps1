# Dedicated to my Shree DR.MDD

$Global:ColorCodes = @("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
$Global:Multipliers = @("", "kilo", "mega", "giga")

Function Get-ResistorLabel() {
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )
    $Resistance = ($Global:ColorCodes.IndexOf($Colors[0]) * 10 + $Global:ColorCodes.IndexOf($Colors[1])) *
        [Math]::Pow(10, $Global:ColorCodes.IndexOf($Colors[2]))
    $Magnitude = 0
    While ($Resistance -ge 1000) {
        $Resistance /= 1000
        $Magnitude++
    }
    "$Resistance " + $Global:Multipliers[$Magnitude] + "ohms"
}
