# Dedicated to Junko F. Didi and Shree DR.MDD

oo::class create ComplexNumber {
    variable rePart imPart

    constructor {r i} {
        set rePart $r
        set imPart $i
    }

    method real {} {
        set rePart
    }

    method imag {} {
        set imPart
    }

    method toList {} {
        list $rePart $imPart
    }

    method add {other} {
        [self class] new [expr {$rePart + [$other real]}] [expr {$imPart + [$other imag]}]
    }

    method sub {other} {
        [self class] new [expr {$rePart - [$other real]}] [expr {$imPart - [$other imag]}]
    }

    method mul {other} {
        set x $rePart
        set y $imPart
        set u [$other real]
        set v [$other imag]
        [self class] new [expr {$x * $u - $y * $v}] [expr {$x * $v + $y * $u}]
    }

    method div {other} {
        set x $rePart
        set y $imPart
        set u [$other real]
        set v [$other imag]
        if {$x == 0 && $u == 0} {
            [self class] new [expr {double($y) / double($v)}] 0.0
        } elseif {$y == 0 && $v == 0} {
            [self class] new [expr {double($x) / double($u)}] 0.0
        } else {
            [self class] new \
                [expr {double($x * $u + $y * $v) / double($u * $u + $v * $v)}] \
                [expr {double($y * $u - $x * $v) / double($u * $u + $v * $v)}]
        }
    }

    method abs {} {
        expr {sqrt($rePart * $rePart + $imPart * $imPart)}
    }

    method conj {} {
        [self class] new $rePart [expr {-$imPart}]
    }

    method exp {} {
        [self class] new [expr {exp($rePart) * cos($imPart)}] [expr {exp($rePart) * sin($imPart)}]
    }
}

proc ::tcl::mathfunc::cr_add {a b} {
    if {! [info object isa typeof $a ComplexNumber]} {
        set a [ComplexNumber new $a 0]
    }
    if {! [info object isa typeof $b ComplexNumber]} {
        set b [ComplexNumber new $b 0]
    }
    $a add $b
}

proc ::tcl::mathfunc::cr_sub {a b} {
    if {! [info object isa typeof $a ComplexNumber]} {
        set a [ComplexNumber new $a 0]
    }
    if {! [info object isa typeof $b ComplexNumber]} {
        set b [ComplexNumber new $b 0]
    }
    $a sub $b
}

proc ::tcl::mathfunc::cr_mul {a b} {
    if {! [info object isa typeof $a ComplexNumber]} {
        set a [ComplexNumber new $a 0]
    }
    if {! [info object isa typeof $b ComplexNumber]} {
        set b [ComplexNumber new $b 0]
    }
    $a mul $b
}

proc ::tcl::mathfunc::cr_div {a b} {
    if {! [info object isa typeof $a ComplexNumber]} {
        set a [ComplexNumber new $a 0]
    }
    if {! [info object isa typeof $b ComplexNumber]} {
        set b [ComplexNumber new $b 0]
    }
    $a div $b
}
