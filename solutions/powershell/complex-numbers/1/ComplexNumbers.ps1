# For Shree DR.MDD

class ComplexNumber {
    [double]$real
    [double]$imaginary

    ComplexNumber([double]$real, [double]$imaginary) {
        $this.real = $real
        $this.imaginary = $imaginary
    }

    [bool]
    Equals([Object]$other) {
        return $this.real -eq $other.real -and $this.imaginary -eq $other.imaginary
    }

    [ComplexNumber]
    static toComplex($obj) {
        if ($obj.gettype() -notin [int],[double],[ComplexNumber]) {
            throw "$obj cannot be converted to type [ComplexNumber]"
        }
        if ($obj.gettype() -in [int],[double]) {
            $obj = [ComplexNumber]::new($obj,0)
        }
        return $obj
    }

    [ComplexNumber]
    static op_Addition($x,$y) {
        $x = [ComplexNumber]::toComplex($x)
        $y = [ComplexNumber]::toComplex($y)
        $r = $x.real + $y.real
        $i = $x.imaginary + $y.imaginary
        return [ComplexNumber]::new($r,$i)
    }

    [ComplexNumber]
    static op_Subtraction($x,$y) {
        $x = [ComplexNumber]::toComplex($x)
        $y = [ComplexNumber]::toComplex($y)
        $r = $x.real - $y.real
        $i = $x.imaginary - $y.imaginary
        return [ComplexNumber]::new($r,$i)
    }

    [ComplexNumber]
    static op_Multiply($x,$y) {
        $x = [ComplexNumber]::toComplex($x)
        $y = [ComplexNumber]::toComplex($y)
        $r = $x.real * $y.real - $x.imaginary * $y.imaginary
        $i = $x.imaginary * $y.real + $y.imaginary * $x.real
        return [ComplexNumber]::new($r,$i)
    }

    [ComplexNumber]
    static op_Division($x,$y) {
        $x = [ComplexNumber]::toComplex($x)
        $y = [ComplexNumber]::toComplex($y)
        $den = [math]::Pow($y.real,2) + [math]::Pow($y.imaginary,2)
        $r = ($x.real * $y.real + $x.imaginary * $y.imaginary)/$den
        $i = ($x.imaginary * $y.real - $x.real * $y.imaginary)/$den
        return [ComplexNumber]::new($r,$i)
    }

    [ComplexNumber]
    Conjugate() {
        return [ComplexNumber]::new($this.real, -1 * $this.imaginary)
    }

    [double]
    Abs() {
        return [math]::Sqrt([math]::Pow($this.real,2) + [math]::Pow($this.imaginary,2))
    }

    [ComplexNumber]
    Exp() {
        $expR = [math]::Pow([math]::E, $this.real)
        $r = [math]::Round($expR * [math]::Cos($this.imaginary), 15)
        $i = [math]::Round($expR * [math]::Sin($this.imaginary), 15)
        return [ComplexNumber]::new($r,$i)
    }
}
