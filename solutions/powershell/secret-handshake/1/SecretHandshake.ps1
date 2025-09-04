# Dedicated to my Shree DR.MDD

$Global:gestures = @("wink", "double blink", "close your eyes", "jump")

Function Invoke-SecretHandshake() {
    [CmdletBinding()]
    Param(
        [int]$Number
    )
    (($Number -band 0x10) ? @(3..0) : @(0..3)).Where({ $Number -band (1 -shl $_) }) | ForEach-Object { $Global:gestures[$_] }
}
