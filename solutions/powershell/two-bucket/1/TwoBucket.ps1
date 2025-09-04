# For Shree DR.MDD

Class TwoBucket {
    [string[]]$BucketIds
    [int[]]$Sizes

    TwoBucket([int]$cap1, [int]$cap2, [string]$first) {
        $this.BucketIds = ($first -eq "one") ? @("one", "two") : @("two", "one")
        $this.Sizes = ($first -eq "one") ? @($cap1, $cap2) : @($cap2, $cap1)
    }

    [object] Measure([int]$goal) {
        if ($this.Sizes[0] -eq $this.Sizes[1]) { throw "Two buckets can't be of the same size" }
        if ($goal -lt 0 -or $goal -gt [Math]::Max($this.Sizes[0], $this.Sizes[1]) -or
            $goal % $this.ComputeGcd()) {
            throw "Target is impossible to reach"
        }

        $buckets = @($this.Sizes[0], 0)

        for (($steps = 1), ($idx = $buckets.IndexOf($goal)); $idx -lt 0; ($steps++), ($idx = $buckets.IndexOf($goal))) {
            if ($this.Sizes[1] -eq $goal) { $buckets[1] = $goal }
            elseif ($buckets[1] -eq $this.Sizes[1]) { $buckets[1] = 0 }
            elseif ($buckets[0] -eq 0) { $buckets[0] = $this.Sizes[0] }
            else {
                $total = $buckets[0] + $buckets[1]
                $buckets = @([Math]::Max(0, $total - $this.Sizes[1]), [Math]::Min($total, $this.Sizes[1]))
            }
        }

        return @{Moves = $steps; GoalBucket = $this.BucketIds[$idx]; OtherBucket = $buckets[1 - $idx] }
    }

    hidden [int] ComputeGcd() {
        $x, $y = $this.Sizes
        while ($y) { $x, $y = $y, ($x % $y) }
        return $x
    }
}
