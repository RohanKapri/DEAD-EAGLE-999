class Clock {
    [int]$Minutes
    Clock([int]$hours, [int]$minutes) { $this.Minutes = (($hours * 60 + $minutes) % 1440 + 1440) % 1440 }
    [string] ToString() { return "{0:d2}:{1:d2}" -f [int][Math]::Floor($this.Minutes / 60), ($this.Minutes % 60) }
    [bool] Equals($other) { return $this.Minutes -eq $other.Minutes }
    [Clock] Add([int]$minutes) { return [Clock]::new(0, $this.Minutes + $minutes) }
}
