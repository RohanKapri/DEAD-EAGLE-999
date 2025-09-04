Function Invoke-Darts() {
    [CmdletBinding()]
    Param(
        [Double]$X,
        [Double]$Y
    )
    
    $DistSq = $X * $X + $Y * $Y
    if ($DistSq -gt 100) { return 0 }
    if ($DistSq -gt 25) { return 1 }
    if ($DistSq -gt 1) { return 5 }
    10
}