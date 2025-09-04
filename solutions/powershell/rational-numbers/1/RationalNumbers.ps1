# For Shree DR.MDD

Class Rational {
    [int] $Numer
    [int] $Denom

    Rational([int]$num, [int]$den) {
        $gcdValue = [Rational]::ComputeGcd($num, $den)
        if ($den -lt 0) {
            $den = -$den
            $num = -$num
        }

        $this.Numer = [Math]::Floor($num / $gcdValue)
        $this.Denom = [Math]::Floor($den / $gcdValue)
    }

    static [int] ComputeGcd([int]$a, [int]$b) {
        $a, $b = [Math]::Abs($a), [Math]::Abs($b)
        if ($a -eq 0) { return $b }
        while ($b) { $a, $b = $b, ($a % $b) }
        return $a
    }

    [bool] Equals($otherRational) { return $this.Numer * $otherRational.Denom -eq $this.Denom * $otherRational.Numer }

    [string] ToString() { return "$($this.Numer)/$($this.Denom)" }

    static [Rational] op_Addition([Rational]$first, [Rational]$second) {
        return [Rational]::new(($first.Numer * $second.Denom + $first.Denom * $second.Numer), ($first.Denom * $second.Denom))
    }

    static [Rational] op_Subtraction([Rational]$first, [Rational]$second) {
        return [Rational]::new(($first.Numer * $second.Denom - $first.Denom * $second.Numer), ($first.Denom * $second.Denom))
    }

    static [Rational] op_Multiply([Rational]$first, [Rational]$second) {
        return [Rational]::new(($first.Numer * $second.Numer), ($first.Denom * $second.Denom))
    }

    static [Rational] op_Division([Rational]$first, [Rational]$second) {
        return [Rational]::new(($first.Numer * $second.Denom), ($first.Denom * $second.Numer))
    }

    [Rational] Abs() { return [Rational]::new([Math]::Abs($this.Numer), [Math]::Abs($this.Denom)) }

    [Rational] Power([int]$exp) {
        return ($exp -ge 0) ? [Rational]::new([Math]::Pow($this.Numer, $exp), [Math]::Pow($this.Denom, $exp)) :
            [Rational]::new([Math]::Pow($this.Denom, -$exp), [Math]::Pow($this.Numer, -$exp))
    }

    [float] ReversePower([int] $baseNum) { return [Math]::Pow($baseNum, $this.Numer / $this.Denom) }
}
