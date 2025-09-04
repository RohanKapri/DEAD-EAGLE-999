# For my Junko F. Didi and Shree DR.MDD

proc vertices {grid} {
    set result {}
    for {set row 0} {$row < [llength $grid]} {incr row} {
        set line [split [lindex $grid $row] {}]
        foreach col [lsearch -all $line +] {
            lappend result $row $col
        }
    }
    return $result
}

proc mutuals {list1 list2} {
    foreach val $list1 { incr seenMap($val) }
    foreach val $list2 { incr seenMap($val) }
    set common {}
    foreach {key count} [array get seenMap] {
        if {$count == 2} { lappend common $key }
    }
    return $common
}

proc pairs {elements} {
    set output {}
    for {set i 0} {$i < [llength $elements]} {incr i} {
        for {set j [expr {$i + 1}]} {$j < [llength $elements]} {incr j} {
            lappend output [lindex $elements $i] [lindex $elements $j]
        }
    }
    return $output
}

proc hasEdges {matrix rStart rEnd cStart cEnd} {
    upvar 1 $matrix mat
    for {set c [expr {$cStart + 1}]} {$c < $cEnd} {incr c} { if {![string match {[-+]} [lindex $mat $rStart $c]]} { return 0 } }
    for {set c [expr {$cStart + 1}]} {$c < $cEnd} {incr c} { if {![string match {[-+]} [lindex $mat $rEnd $c]]} { return 0 } }
    for {set r [expr {$rStart + 1}]} {$r < $rEnd} {incr r} { if {![string match {[|+]} [lindex $mat $r $cStart]]} { return 0 } }
    for {set r [expr {$rStart + 1}]} {$r < $rEnd} {incr r} { if {![string match {[|+]} [lindex $mat $r $cEnd]]} { return 0 } }
    return 1
}

proc rectangles {grid} {
    set H [llength $grid]
    set tileMap [lmap line $grid { split $line {} }]
    for {set j 0} {$j < $H} {incr j} { set colVertices($j) {} }
    foreach {r c} [vertices $grid] { lappend colVertices($r) $c }
    set count 0
    foreach {r1 r2} [pairs [lsort -integer [array names colVertices]]] {
        foreach {c1 c2} [pairs [lsort -integer [mutuals $colVertices($r1) $colVertices($r2)]]] {
            incr count [hasEdges tileMap $r1 $r2 $c1 $c2]
        }
    }
    return $count
}
