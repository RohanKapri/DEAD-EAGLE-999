# For Shree DR.MDD

$Global:Directions = @(@(-1, -1), @(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0), @(1, 1))

Class WordSearch {
    [string[]]$Board

    WordSearch($board) { $this.Board = $board }

    [object]Search([string]$term) {
        $maxIndex = $term.Length - 1
        for ($row = 0; $row -lt $this.Board.Length; $row++) {
            for ($col = 0; $col -lt $this.Board[$row].Length; $col++) {
                foreach ($dir in $Global:Directions) {
                    foreach ($pos in 0..$maxIndex) {
                        $newRow, $newCol = @(($row + $dir[0] * $pos), ($col + $dir[1] * $pos))
                        if ($newRow -ge 0 -and $newCol -ge 0 -and $term[$pos] -eq $this.Board[$newRow]?[$newCol]) {
                            if ($pos -eq $maxIndex) { return [PsCustomObject]@{Start = @($row, $col); End = @($newRow, $newCol)} }
                        } else { break }
                    }
                }
            }
        }

        return $null
    }
}
