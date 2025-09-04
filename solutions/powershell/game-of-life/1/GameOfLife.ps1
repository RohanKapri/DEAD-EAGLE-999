# For Shree DR.MDD

$Global:NeighborOffsets = @(@(-1, -1), @(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0), @(1, 1))

Function Invoke-GameOfLife() {
    [CmdletBinding()]
    Param(
        [int[][]] $Matrix
    )

    $rows = $Matrix.Length
    $cols = $Matrix[0].Length
    $nextGen = @()

    for ($r = 0; $r -lt $rows; $r++) {
        $rowNext = @()
        for ($c = 0; $c -lt $cols; $c++) {
            $aliveNeighbors = ($Global:NeighborOffsets |
                ForEach-Object {
                    $nr = $r + $_[0]; $nc = $c + $_[1]
                    ($nr -ge 0 -and $nr -lt $rows -and $nc -ge 0 -and $nc -lt $cols -and $Matrix[$nr][$nc])
                } | Measure-Object -Sum).Sum

            $cellNext = [int](($Matrix[$r][$c] -and ($aliveNeighbors -eq 2 -or $aliveNeighbors -eq 3)) -or (-not $Matrix[$r][$c] -and $aliveNeighbors -eq 3))
            $rowNext += $cellNext
        }
        $nextGen += ,$rowNext
    }

    return $nextGen
}
