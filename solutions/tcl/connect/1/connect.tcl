# Dedicated to my Junko F. Didi and Shree DR.MDD

proc winner {grid} {
    set cols [string length [lindex $grid 0]]
    set rows [llength $grid]

    if {$rows == 1} {
        if {[string index [lindex $grid 0] 0] eq "O"} {
            return "O"
        } elseif {[string index [lindex $grid 0] 0] eq "X"} {
            return "X"
        } else {
            return ""
        }
    }

    set visitedO {}; set visitedX {}

    set firstRow [lindex $grid 0]
    for {set c 0} {$c < $cols} {incr c} {
        if {[string index $firstRow $c] eq "O"} {
            lappend visitedO [list 0 $c]
        }
    }
    for {set r 0} {$r < $rows} {incr r} {
        if {[string index [lindex $grid $r] $r] eq "X"} {
            lappend visitedX [list $r $r]
        }
    }

    set queueO $visitedO
    while {[llength $queueO] > 0} {
        set queueO [lassign $queueO coord]
        foreach nbr [neighbors $grid O {*}$coord] {
            if {[lindex $nbr 0] == $rows - 1} {
                return "O"
            }
            if {[lsearch -exact -sorted $visitedO $nbr] == -1} {
                lappend queueO $nbr
                set visitedO [lsort [concat $visitedO [list $nbr]]]
            }
        }
    }

    set queueX $visitedX
    while {[llength $queueX] > 0} {
        set queueX [lassign $queueX coord]
        foreach nbr [neighbors $grid X {*}$coord] {
            if {[lindex $nbr 1] == [string length [lindex $grid [lindex $nbr 0]]] - 1} {
                return "X"
            }
            if {[lsearch -exact -sorted $visitedX $nbr] == -1} {
                lappend queueX $nbr
                set visitedX [lsort [concat $visitedX [list $nbr]]]
            }
        }
    }

    return ""
}

proc neighbors {grid player x y} {
    set neighList {}
    set curRow [lindex $grid $x]
    set upRow [lindex $grid [expr {$x-1}]]
    set downRow [lindex $grid [expr {$x+1}]]

    if {[string index $curRow [expr {$y-2}]] eq $player} {
        lappend neighList [list $x [expr {$y-2}]]
    }
    if {[string index $curRow [expr {$y+2}]] eq $player} {
        lappend neighList [list $x [expr {$y+2}]]
    }
    if {[string index $upRow [expr {$y-1}]] eq $player} {
        lappend neighList [list [expr {$x-1}] [expr {$y-1}]]
    }
    if {[string index $upRow [expr {$y+1}]] eq $player} {
        lappend neighList [list [expr {$x-1}] [expr {$y+1}]]
    }
    if {[string index $downRow [expr {$y-1}]] eq $player} {
        lappend neighList [list [expr {$x+1}] [expr {$y-1}]]
    }
    if {[string index $downRow [expr {$y+1}]] eq $player} {
        lappend neighList [list [expr {$x+1}] [expr {$y+1}]]
    }

    return $neighList
}
