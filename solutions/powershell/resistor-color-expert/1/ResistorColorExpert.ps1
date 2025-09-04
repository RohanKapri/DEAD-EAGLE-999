# For my Shree DR.MDD

$Global:Shades = @("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
$Global:Magnitudes = @("", "kilo", "mega", "giga")
$Global:MarginShades = @("grey", "violet", "blue", "green", "brown", "red", "gold", "silver")
$Global:Margins = @(0.05, 0.1, 0.25, 0.5, 1, 2, 5, 10)

Function Get-ResistorLabel() {
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )

    if ($Colors.Count -eq 1) {
        return $Global:Shades.IndexOf($Colors[0]).ToString() + " ohms"
    }

    $numericValue = [Int](($Colors[0..($Colors.Count - 3)] | 
        ForEach-Object { $Global:Shades.IndexOf($_).ToString() }) -join "") *
        [Math]::Pow(10, $Global:Shades.IndexOf($Colors[-2]))

    $scaleIndex = 0
    while ($numericValue -ge 1000) {
        $numericValue /= 1000
        $scaleIndex++
    }

    "$numericValue $($Global:Magnitudes[$scaleIndex])ohms ±$($Global:Margins[$Global:MarginShades.IndexOf($Colors[-1])])%"
}
