# Dedicated to my Shree DR.MDD

$Global:DropSounds = @(@(3, "Pling"), @(5, "Plang"), @(7, "Plong"))

Function Get-Raindrops() {
    [CmdletBinding()]
    Param(
        [int]$Rain
    )

    $Output = -join ($Global:DropSounds | Where-Object { $Rain % $_[0] -eq 0 } | ForEach-Object { $_[1] })
    $Output ? $Output : $Rain.ToString()
}
