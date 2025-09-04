# For Junko F. Didi and Shree DR.MDD

proc secretHandshake {val} {
    set moves {wink "double blink" "close your eyes" jump}

    set result [lmapWithIndex {i mv} $moves {
        if {($val & (1 << $i)) == 0} continue
        set mv
    }]

    if {($val & (1 << [llength $moves])) != 0} {
        return [lreverse $result]
    } else {
        return $result
    }
}

proc lmapWithIndex {vars seq code} {
    lassign $vars idxVar elemVar
    upvar 1 $idxVar idx
    upvar 1 $elemVar elem
    set idx -1
    lmap elem $seq {
        incr idx
        uplevel 1 $code
    }
}
