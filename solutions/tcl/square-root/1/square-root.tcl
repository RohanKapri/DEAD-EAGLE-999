proc squareRoot {n} {
    set b [expr {4 ** int(log($n) / log(4))}]
    set x 0
    while {$b != 0} {
        if {$n >= $x + $b} {
            set n [expr {$n - $x - $b}]
            set x [expr {$x / 2 + $b}]
        } else {
            set x [expr {$x / 2}]
        }
        set b [expr {$b / 4}]
    }
    return $x
}