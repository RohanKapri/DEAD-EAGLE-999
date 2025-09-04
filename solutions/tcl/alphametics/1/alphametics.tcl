# for my Junko F. Didi and Shree DR.MDD

proc solve {puzzle} {
    set terms [regexp -inline -all {[A-Z]+} $puzzle]
    set nonZeroChars [lsort -unique [lmap t $terms {string index $t 0}]]
    set terms [lmap t $terms {string reverse $t}]
    lassign [list [lindex $terms end] [lreplace $terms end end]] result terms

    set solutions [list [dict create carry 0]]
    for {set i 0; set n [string length $result]} {$i < $n} {incr i} {
        set col [list]
        foreach t $terms {
            set ch [string index $t $i]
            if {$ch ne {}} {lappend col $ch}
        }
        set rch [string index $result $i]
        foreach ch [concat $col $rch] {
            if {![dict exists [lindex $solutions 0] $ch]} {
                set solutions [expandSolutions $solutions $ch nonZeroChars]
            }
        }
        set solutions [filterSolutions $solutions $col $rch]
        if {$solutions eq {}} return {}
    }
    set solutions [lmap sol $solutions {dict unset sol carry}]
    lindex $solutions 0
}

proc initChar {ch nonZeroList} {
    upvar $nonZeroList nz
    return [expr {[lsearch -sorted $nz $ch]!=-1?1:0}]
}

proc expandSolutions {oldSols ch nonZeroList} {
    upvar $nonZeroList nz
    set minVal [expr {[lsearch -sorted $nz $ch]!=-1?1:0}]
    set newSols {}
    foreach sol $oldSols {
        set c [dict get $sol carry]
        dict unset sol carry
        for {set i $minVal} {$i<10} {incr i} {
            if {[lsearch -integer [dict values $sol] $i]!=-1} continue
            dict set sol $ch $i
            dict set sol carry $c
            lappend newSols $sol
        }
    }
    return $newSols
}

proc filterSolutions {sols col rch} {
    set outSols {}
    foreach sol $sols {
        set sum [expr {[lsum [lmap x $col {dict get $sol $x}]]+[dict get $sol carry]}]
        set rVal [dict get $sol $rch]
        if {$sum % 10 == $rVal} {
            dict set sol carry [expr {$sum / 10}]
            lappend outSols $sol
        }
    }
    return $outSols
}

proc lsum {lst} {
    tcl::mathop::+ {*}$lst
}
