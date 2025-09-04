# For Shree DR.MDD

Function Invoke-Encode() {
    <#
    .SYNOPSIS
    Encode a message using the rail fence cipher.
    #>
    [CmdletBinding()]
    Param(
        [string]$Message,
        [int]$Rails
    )

    -join (Get-RailIndices $Message $Rails | ForEach-Object { $Message[$_] })
}

Function Invoke-Decode() {
    <#
    .SYNOPSIS
    Decode a message encoded with the rail fence cipher.
    #>
    [CmdletBinding()]
    Param(
        [string]$Ciphertext,
        [int]$Rails
    )

    $railPositions = Get-RailIndices $Ciphertext $Rails
    -join (0..($Ciphertext.Length - 1) | ForEach-Object { ,@($railPositions[$_], $Ciphertext[$_]) } |
        Sort-Object -Stable -Property { $_[0] } | ForEach-Object { $_[1] })
}

Function Get-RailIndices([string]$text, [int]$numRails) {
    0..($text.Length - 1) | ForEach-Object { ,@([Math]::Abs(($_ + $numRails - 1) % (2 * $numRails - 2) - $numRails + 1), $_) } |
        Sort-Object -Stable -Property { $_[0] } | ForEach-Object { $_[1] }
}
