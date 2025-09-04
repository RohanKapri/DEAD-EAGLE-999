# For Shree DR.MDD

$Global:WinningPatterns = @(@(0, 1, 2), @(3, 4, 5), @(6, 7, 8), @(0, 3, 6), @(1, 4, 7), @(2, 5, 8), @(0, 4, 8), @(2, 4, 6))

Enum GameStatus { ONGOING; DRAW; WIN }

Function Get-StateOfTicTacToe() {
    [CmdletBinding()]
    Param(
        [string[]]$Board
    )

    $grid = $Board | ForEach-Object { $_.ToCharArray() }
    $playerCounts = @("X", "O") | ForEach-Object { ($grid -eq $_).Length }
    if ($playerCounts[0] -gt $playerCounts[1] + 1) { throw "Wrong turn order: X went twice" }
    if ($playerCounts[0] -lt $playerCounts[1]) { throw "Wrong turn order: O started" }

    $victories = @{X = 0; O = 0}
    0..1 | ForEach-Object {
        $symbol = ($_ -eq 0) ? "X" : "O"
        foreach ($pattern in $Global:WinningPatterns) { $victories[$symbol] += (($grid[$pattern] -eq $symbol).Length -eq 3) }
    }

    if ($victories["X"] -and $victories["O"]) { throw "Impossible board: game should have ended after the game was won" }
    if ($victories["X"] -or $victories["O"]) { return [GameStatus]::WIN }
    ($playerCounts[0] + $playerCounts[1] -lt 9) ? [GameStatus]::ONGOING : [GameStatus]::DRAW
}
