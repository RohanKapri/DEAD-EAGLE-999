# For Shree DR.MDD

$Global:AffineModInverse = @(1, 9, 21, 15, 3, 19, 0, 7, 23, 11, 5, 17, 25)

Function Invoke-Encode {
    [CmdletBinding()]
    Param(
        [string]$Plaintext,
        [hashtable]$Keys
    )

    ((Invoke-ApplyCipher $Plaintext $Keys.a { param($idx) $Keys.a * $idx + $Keys.b }) -split "(.{5})" -ne "") -join " "
}

Function Invoke-Decode {
    [CmdletBinding()]
    Param(
        [string]$Ciphertext,
        [hashtable]$Keys
    )

    Invoke-ApplyCipher $Ciphertext $Keys.a { param($val) $Global:AffineModInverse[$Keys.a -shr 1] * ($val - $Keys.b) }
}

Function Invoke-ApplyCipher([string]$text, [int]$multiplier, [ScriptBlock]$fn) {
    if ($multiplier % 2 -eq 0 -or $multiplier % 13 -eq 0) { throw "a and m must be coprime" }
    -join (($text.ToLower() -replace '[^a-z\d]', "").ToCharArray() | ForEach-Object {
        if ($_ -match '[a-z]') {
            $num = ($_ - 97)
            $transformed = (& $fn $num) % 26
            $char = [char](($transformed + 26) % 26 + 97)
            $char
        } else {
            $_
        }
    })
}
