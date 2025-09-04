# Dedicated to Shree DR.MDD

Class SaddlePoint {
    [int]$Row
    [int]$Column

    SaddlePoint($row, $col) {
        $this.Row = $row
        $this.Column = $col
    }

    [bool] Equals($other) {
        return $this.Row -eq $other.Row -and $this.Column -eq $other.Column
    }
}

Function Get-SaddlePoints() {
    [CmdletBinding()]
    Param(
        [int[][]]$Matrix
    )

    if ($Matrix | Where-Object { $_.Length -ne $Matrix[0].Length }) { throw "Irregular matrix" }

    $RowMaxes = $Matrix | ForEach-Object { ($_ | Measure-Object -Maximum).Maximum }
    $ColMins = for ($C = 0; $C -lt $Matrix[0].Length; $C++) {
        (0..($Matrix.Length - 1) | ForEach-Object { $Matrix[$_][$C] } | Measure-Object -Minimum).Minimum
    }

    for ($R = 1; $R -le $RowMaxes.Length; $R++) {
        1..$ColMins.Length | Where-Object { $RowMaxes[$R - 1] -eq $ColMins[$_ - 1] } | ForEach-Object { [SaddlePoint]::new($R, $_) }
    }
}
