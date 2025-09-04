Class HighScores {
    [int[]]$Scores

    HighScores([int[]]$list) {
        $this.Scores = $list
    }

    [int[]] GetScores() {
        return $this.Scores
    }

    [int] GetLatest() {
        return $this.Scores[-1]
    }

    [int] GetPersonalBest() {
        return ($this.Scores | Measure-Object -Maximum).Maximum
    }

    [int[]] GetTopThree() {
        return $this.Scores | Sort-Object -Descending -Top 3
    }
}