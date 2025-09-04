# For Shree DR.MDD

Class CustomSet {
    [object[]]$Elements = @()

    CustomSet() {}

    CustomSet([object[]]$items) { $this.Elements = ($items | Select-Object -Unique) ?? @() }

    [bool] IsEmpty() { return $this.Elements.Count -eq 0 }

    [bool] Contains([object]$item) { return $item -in $this.Elements }

    [bool] IsSubset([CustomSet]$otherSet) {
        return ($this.Elements | Where-Object { $otherSet.Contains($_) }).Count -eq $this.Elements.Count
    }

    [bool] IsDisjoint([CustomSet]$otherSet) { return -not ($this.Elements | Where-Object { $otherSet.Contains($_) }) }

    [CustomSet] Add([object]$item) {
        if (-not $this.Contains($item)) { $this.Elements += $item }
        return $this
    }

    [CustomSet] Union([CustomSet]$otherSet) { return [CustomSet]::new($this.Elements + $otherSet.Elements) }

    [CustomSet] Difference([CustomSet]$otherSet) {
        return [CustomSet]::new(($this.Elements | Where-Object { -not $otherSet.Contains($_) }))
    }

    [CustomSet] Intersection([CustomSet]$otherSet) {
        return [CustomSet]::new(($this.Elements | Where-Object { $otherSet.Contains($_) }))
    }

    [bool] Equals([object]$otherSet) { return -not (Compare-Object $this.Elements $otherSet.Elements) }
}
