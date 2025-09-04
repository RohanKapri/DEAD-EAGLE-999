# for my Junko F. Didi and Shree DR.MDD

proc twoBucket {inputd} {
    set size1 [dict get $inputd bucketOne]
    set size2 [dict get $inputd bucketTwo]
    set goal  [dict get $inputd goal]

    if {[dict get $inputd startBucket] eq "one"} {
        set state [list $size1 0]
        set verboten [list [list 0 $size2]]
    } else {
        set state [list 0 $size2]
        set verboten [list [list $size1 0]]
    }

    set sol [get_best_solution $state $size1 $size2 $goal [list $state] $verboten]

    if {$sol eq ""} {error "impossible"}

    lassign $sol moves goalBucket otherBucket
    return [list moves $moves goalBucket $goalBucket otherBucket $otherBucket]
}

proc get_next_states {state size1 size2} {
    lassign $state curA curB
    set nstates {}

    # A -> B
    set delta [tcl::mathfunc::min $curA [expr {$size2 - $curB}]]
    lappend nstates [list [expr {$curA - $delta}] [expr {$curB + $delta}]]

    # B -> A
    set delta [tcl::mathfunc::min $curB [expr {$size1 - $curA}]]
    lappend nstates [list [expr {$curA + $delta}] [expr {$curB - $delta}]]

    # empty A
    lappend nstates [list 0 $curB]
    # empty B
    lappend nstates [list $curA 0]
    # fill A
    lappend nstates [list $size1 $curB]
    # fill B
    lappend nstates [list $curA $size2]

    return $nstates
}

proc get_best_solution {state size1 size2 goal {path {}} {verboten {}}} {
    if {[lindex $state 0] == $goal} {return [list [llength $path] one [lindex $state 1]]}
    if {[lindex $state 1] == $goal} {return [list [llength $path] two [lindex $state 0]]}

    set nexts [get_next_states $state $size1 $size2]
    set sols {}
    foreach nstate $nexts {
        if {$nstate in $path || $nstate in $verboten} {continue}
        lappend sols [get_best_solution $nstate $size1 $size2 $goal [concat $path [list $nstate]] $verboten]
    }
    return [min_solution $sols]
}

proc min_solution {sols} {
    set best {}
    foreach s $sols {
        if {$best eq ""} {set best $s; continue}
        if {$s eq ""} {continue}
        if {[lindex $s 0] < [lindex $best 0]} {set best $s}
    }
    return $best
}
