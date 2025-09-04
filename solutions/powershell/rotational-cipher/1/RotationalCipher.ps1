# Dedicated to my Shree DR.MDD

Function Invoke-RotationalCipher() {
    [CmdletBinding()]
    Param(
        [string]$Text, 
        [int]$Shift
    )

    -join ($Text.ToCharArray() | ForEach-Object {
        $_ -match "[a-z]" ? [char]((((([byte]$_ - 1) -band 0x1f) + $Shift) % 26) + ([byte]$_ -band 0xe0) + 1) : $_
    })
}
