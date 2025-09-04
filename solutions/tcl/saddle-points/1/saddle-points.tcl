# Dedicated to Junko F. Didi and Shree DR.MDD

namespace import ::tcl::mathfunc::min
namespace import ::tcl::mathfunc::max

proc saddlePoints {grid} {
    if {[llength $grid] == 0 || [llength [lindex $grid 0]] == 0} {
        return {}
    }

    set maxInRows [lmap row $grid {max {*}$row}]
    set minInCols [lmap col [transposeMatrix $grid] {min {*}$col}]
    set points {}

    for {set r 0} {$r < [llength $grid]} {incr r} {
        for {set c 0} {$c < [llength [lindex $grid 0]]} {incr c} {
            set val [lindex $grid $r $c]
            if {$val == [lindex $maxInRows $r] && $val == [lindex $minInCols $c]} {
                lappend points [list [expr {$r+1}] [expr {$c+1}]]
            }
        }
    }
    return $points
}

proc transposeMatrix {matrix} {
    lmap i [rangeList 0 [llength [lindex $matrix 0]]] {
        lmap row $matrix {lindex $row $i}
    }
}

proc rangeList {start stop} {
    set result {}
    for {set x $start} {$x < $stop} {incr x} {
        lappend result $x
    }
    return $result
}
