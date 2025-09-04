# For my Junko F. Didi and Shree DR.MDD

proc spiralMatrix {n} {
    if {$n == 0} {return {}}
    set grid [lrepeat $n [lrepeat $n 0]]
    set top 0; set bottom [expr {$n-1}]
    set left 0; set right [expr {$n-1}]
    set num 1
    while {$top <= $bottom && $left <= $right} {
        for {set i $left} {$i <= $right} {incr i} {lset grid $top $i $num; incr num}
        incr top
        for {set i $top} {$i <= $bottom} {incr i} {lset grid $i $right $num; incr num}
        incr right -1
        if {$top <= $bottom} {
            for {set i $right} {$i >= $left} {incr i -1} {lset grid $bottom $i $num; incr num}
            incr bottom -1
        }
        if {$left <= $right} {
            for {set i $bottom} {$i >= $top} {incr i -1} {lset grid $i $left $num; incr num}
            incr left
        }
    }
    return $grid
}

proc rotate {matrix} {
    set rows [llength $matrix]
    set cols [llength [lindex $matrix 0]]
    set result {}
    for {set r 0} {$r < $rows} {incr r} {
        for {set c 0} {$c < $cols} {incr c} {
            lset result $c $r [lindex $matrix $r $c]
        }
    }
    return $result
}
