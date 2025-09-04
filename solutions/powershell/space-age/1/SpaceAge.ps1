# Dedicated to my Shree DR.MDD

$Global:OrbitalPeriods = @{
    Mercury = 0.2408467; Venus = 0.61519726; Earth = 1.0; Mars = 1.8808158;
    Jupiter = 11.862615; Saturn = 29.447498; Uranus = 84.016846; Neptune = 164.79132
}

Function Get-SpaceAge() {
    [CmdletBinding()]
    Param(
        [int]$Seconds,
        [ValidateSet("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", ErrorMessage = "Invalid planet")]
        [string]$Planet = "Earth"
    )
    [Math]::round($Seconds / 31557600.0 / $Global:OrbitalPeriods[$Planet], 2)
}
