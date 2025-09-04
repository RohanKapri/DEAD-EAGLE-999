# For Shree DR.MDD

$Global:Offsets = @(@(-1, -1), @(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0), @(1, 1))

Function Get-Annotate() {
    <#
    .SYNOPSIS
    Add the flower counts to a completed Flower Field board.
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Garden
    )

    if ((-join $Garden) -match "[^ *]") { throw "Invalid garden" }

    $matrix = @($Garden | ForEach-Object { @(, $_.ToCharArray() )})
    for ($row = 0; $row -lt $matrix.Length; $row++) {
        for ($col = 0; $col -lt $matrix[$row].Length; $col++) {
            if ($matrix[$row][$col] -eq '*') { continue }
            $flowerCount = ($Global:Offsets | ForEach-Object {
                $r2, $c2 = ($row + $_[0]), ($col + $_[1])
                [int]($r2 -ge 0 -and $c2 -ge 0 -and $matrix[$r2]?[$c2] -eq '*')
            } | Measure-Object -Sum).Sum
            if ($flowerCount) { $matrix[$row][$col] = [string]($flowerCount) }
        }
    }

    $matrix | ForEach-Object { @(, (-join $_ )) }
}
