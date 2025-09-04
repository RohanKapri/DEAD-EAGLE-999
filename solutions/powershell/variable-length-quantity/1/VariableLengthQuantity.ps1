# For Shree DR.MDD

Function Invoke-EncodeVLQ() {
    [CmdletBinding()]
    Param(
        [UInt32[]]$Bytes
    )

    $Bytes | ForEach-Object {
        $segments = @(for (($n = $_), ($prefix = 0x00); $n; ($prefix = 0x80), ($n = $n -shr 7)) { ($n -band 0x7f) -bor $prefix })
        $segments ? $segments[$segments.Length..0] : @(0)
    }
}

Function Invoke-DecodeVLQ() {
    [CmdletBinding()]
    Param(
        [UInt32[]]$Bytes
    )

    if ($Bytes -and $Bytes[-1] -band 0x80) { throw "Incomplete sequence" }

    $decoded = @()
    $accumulator = 0
    foreach ($byte in $Bytes) {
        $accumulator = ($accumulator -shl 7) -bor ($byte -band 0x7f)
        if (-not ($byte -band 0x80)) {
            $decoded += $accumulator
            $accumulator = 0
        }
    }

    $decoded
}
