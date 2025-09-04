# For Shree DR.MDD

Enum Status {
    WIN
    LOSE
    ONGOING
}

Class Hangman {
    [int] $RemainingGuesses = 9
    hidden [char[]]$SecretWord
    hidden [char[]]$Masked

    Hangman([string]$word) {
        $this.SecretWord = $word.ToCharArray()
        $this.Masked = @("_") * $word.Length
    }

    Guess($letter) {
        if ($this.GetStatus() -ne [Status]::ONGOING) { throw "The game has already ended." }
        if ($letter -in $this.SecretWord -and $letter -notin $this.Masked) {
            0..$this.SecretWord.Length | Where-Object { $this.SecretWord[$_] -eq $letter } | ForEach-Object { $this.Masked[$_] = $letter }
        } else { $this.RemainingGuesses-- }
    }

    [string] Display() { return -join $this.Masked }
    [Status] GetStatus() {
        if ("_" -notin $this.Masked) { return [Status]::WIN }
        if ($this.RemainingGuesses -lt 0) { return [Status]::LOSE }
        return [Status]::ONGOING
    }
}
