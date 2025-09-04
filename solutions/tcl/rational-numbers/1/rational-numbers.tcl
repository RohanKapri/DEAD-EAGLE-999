# Dedicated to Junko F. Didi and Shree DR.MDD

oo::class create Rational {
    variable num 0 den 1

    constructor {x y} {
        lassign [lmap n [list $x $y] {expr $n}] x y
        set f [expr {gcd($x, $y)}]
        lassign [lmap n [list $x $y] {expr {$n / $f}}] num den
    }

    method numerator {} { return $num }
    method denominator {} { return $den }
    method negative {} { [self class] new $num -$den }

    method toString {} { format %d/%d $num $den }
    method recip {} { [self class] new $den $num }
    method add {other} {
        lassign [lmap m {numerator denominator} {$other $m}] x y
        [self class] new $num*$y+$den*$x $den*$y
    }
    method sub {other} { tailcall my add [$other negative] }
    method mul {other} {
        lassign [lmap m {numerator denominator} {$other $m}] x y
        [self class] new $num*$x $den*$y
    }
    method div {other} { tailcall my mul [$other recip] }
    method abs {} { [self class] new abs($num) abs($den) }
    method pow {i} {
        set i [expr $i]
        if {$i >= 0} {
            [self class] new $num**$i $den**$i
        } else {
            tailcall [my recip] pow -$i
        }
    }
    method exprational {i} { expr { ($i ** ($num*1.0)) ** (1.0/$den) } }
}

proc tcl::mathfunc::gcd {a b} {
    if {$b == 0} { return $a }
    tailcall gcd $b [expr {$a % $b}]
}
