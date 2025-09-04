# For Shree DR.MDD

Class BowlingGame {
    [int]$FrameIndex
    [int]$FirstRollPins
    [int]$TotalScore
    [int]$StrikeBonus1 = 0
    [int]$StrikeBonus2 = 0

    BowlingGame() {
        $this.FrameIndex = 0
        $this.FirstRollPins = -1
        $this.TotalScore = 0
        $this.StrikeBonus1 = 0
        $this.StrikeBonus2 = 0
    }

    Roll([int]$pins) {
        if ($pins -lt 0 -or $pins -gt 10) { throw "" }

        if ($this.FrameIndex -eq 10 -and $this.StrikeBonus1 -eq 0 -and $this.StrikeBonus2 -eq 0) { throw "" }

        if ($this.StrikeBonus1 -gt 0) {
            if ($this.FrameIndex -eq 10) {
                if ($this.FirstRollPins -eq -1) {
                    if ($pins -ne 10) { $this.FirstRollPins = $pins }
                } elseif ($this.FirstRollPins + $pins -gt 10) { throw "" }
            }
            $this.TotalScore += $pins * $this.StrikeBonus1
            $this.StrikeBonus1 = 0
        }

        if ($this.StrikeBonus2 -gt 0) {
            $this.StrikeBonus1 = $this.StrikeBonus2
            $this.StrikeBonus2 = 0
        }

        if ($this.FrameIndex -lt 10) {
            if ($this.FirstRollPins -eq -1) {
                if ($pins -eq 10) {
                    $this.TotalScore += 10
                    $this.StrikeBonus1++
                    $this.StrikeBonus2++
                    $this.FrameIndex++
                } else {
                    $this.TotalScore += $pins
                    $this.FirstRollPins = $pins
                }
            } else {
                if ($pins + $this.FirstRollPins -eq 10) { $this.StrikeBonus1++ }
                elseif ($pins + $this.FirstRollPins -gt 10) { throw "" }

                $this.TotalScore += $pins
                $this.FrameIndex++
                $this.FirstRollPins = -1
            }
        }
    }

    [int] Score() {
        if ($this.FrameIndex -eq 10 -and $this.StrikeBonus1 -eq 0 -and $this.StrikeBonus2 -eq 0) { return $this.TotalScore }
        else { throw "" }
    }
}
