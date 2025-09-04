# For Shree DR.MDD

Enum Winner { X; O; NONE }

Class Connect {
    [hashtable]$BoardsMap
    static [int[][]]$Directions = @(@(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0))

    Connect([string[]]$board) {
        $linesClean = $board -replace " ", ""
        $this.BoardsMap = @{
            "O" = $linesClean
            "X" = 0..($linesClean[0].Length - 1) | ForEach-Object { $col = $_; -join (0..($linesClean.Length - 1) | ForEach-Object { $linesClean[$_][$col] }) }
        }
    }

    [Winner] GetWinner() {
        foreach ($player in @("O", "X")) {
            $currentBoard = $this.BoardsMap[$player]
            for ($col = 0 ; $col -lt $currentBoard[0].Length; $col++) {
                if ($currentBoard[0][$col] -eq $player -and $this.CheckWin($player, @(0, $col), @("0,$col"))) {
                    return [Winner]($player)
                }
            }
        }

        return [Winner]::NONE
    }

    hidden [bool] CheckWin([string]$player, [int[]]$point, [string[]]$visited) {
        if ($point[0] -eq $this.BoardsMap[$player].Length - 1) { return $true }
        foreach ($delta in [Connect]::Directions) {
            $nextPt = @(($point[0] + $delta[0]), ($point[1] + $delta[1]))
            if ($nextPt[0] -lt 0 -or $nextPt[1] -lt 0) { continue }
            $key = "$($nextPt[0]),$($nextPt[1])"
            if ($this.BoardsMap[$player][$nextPt[0]]?[$nextPt[1]] -eq $player -and $key -notin $visited) {
                if ($this.CheckWin($player, $nextPt, ($visited + $key))) { return $true }
            }
        }

        return $false
    }
}
