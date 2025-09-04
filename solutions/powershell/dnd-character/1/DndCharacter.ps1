Class Character {
    [int]$Strength
    [int]$Dexterity
    [int]$Constitution
    [int]$Intelligence
    [int]$Wisdom
    [int]$Charisma
    [int]$HitPoints
    Character() {
        [Character].GetProperties().Name | Where-Object { $_ -ne "HitPoints" } | ForEach-Object { $this.$_ = $this.Ability() }
        $this.HitPoints = 10 + [Character]::GetModifier($this.Constitution)
    }

    static [int] GetModifier([int]$Score) {
        return [Math]::Floor(($Score - 10) / 2)
    }
    [int] Ability() {
        $Stats = 1..4 | ForEach-Object { Get-Random -Minimum 1 -Maximum 7 } | Measure-Object -Sum -Minimum
        return $Stats.Sum - $Stats.Minimum
    }
}