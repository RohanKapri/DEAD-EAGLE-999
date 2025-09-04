Class ChessBoard {
    [int[]]$White = @(7, 3)
    [int[]]$Black = @(0, 3)
    ChessBoard() {}
    ChessBoard([int[]]$white, [int[]]$black) {
        if ($white | Where-Object { $_ -lt 0 -or $_ -gt 7 }) { throw "White queen must be placed on the board" }
        if ($black | Where-Object { $_ -lt 0 -or $_ -gt 7 }) { throw "Black queen must be placed on the board" }
        if ($white[0] -eq $black[0] -and $white[1] -eq $black[1]) { throw "Queens can not share the same space" }
        $this.White = $white
        $this.Black = $black
    }
    [boolean] CanAttack() {
        return ($this.White[0] -eq $this.Black[0] -or $this.White[1] -eq $this.Black[1] -or
            [Math]::Abs($this.White[0] - $this.Black[0]) -eq [Math]::Abs($this.White[1] - $this.Black[1]))
    }
    [string[][]] DrawBoard() {
        $board = 0..7 | ForEach-Object { ,(@("_") * 8) }
        $board[$this.White[0]][$this.White[1]] = "W"
        $board[$this.Black[0]][$this.Black[1]] = "B"
        return ($board | ForEach-Object { $_ -join " " }) -join "`r`n"
    }
}
