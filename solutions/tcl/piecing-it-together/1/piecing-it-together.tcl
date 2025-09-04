# Dedicated to my Junko F. Didi and Shree DR.MDD

proc maxSize {} { return 1000 }

proc jigsawData {inputDict} {
    set candidateSolutions [list]

    if {[dict exists $inputDict pieces]} {
        set totalPieces [dict get $inputDict pieces]
        for {set r 1} {$r <= $totalPieces} {incr r} {
            if {$totalPieces % $r == 0} {
                set layout [allData $r [expr {$totalPieces / $r}]]
                if {[matchesCriteria $layout $inputDict]} {
                    lappend candidateSolutions $layout
                }
            }
        }

    } elseif {[dict exists $inputDict inside]} {
        set insideCount [dict get $inputDict inside]
        for {set irows 1} {$irows <= $insideCount} {incr irows} {
            if {$insideCount % $irows == 0} {
                set layout [allData [expr {$irows + 2}] [expr {$insideCount / $irows + 2}]]
                if {[matchesCriteria $layout $inputDict]} {
                    lappend candidateSolutions $layout
                }
            }
        }

    } else {
        for {set r [maxSize]} {$r > 0} {incr r -1} {
            for {set c [maxSize]} {$c > 0} {incr c -1} {
                set layout [allData $r $c]
                if {[matchesCriteria $layout $inputDict]} {
                    lappend candidateSolutions $layout
                }
            }
        }
    }

    switch -- [llength $candidateSolutions] {
        1       {lindex $candidateSolutions 0}
        0       {error "Contradictory data"}
        default {error "Insufficient data"}
    }
}

proc allData {rows cols} {
    set totalPieces [expr {$rows * $cols}]
    set innerCount [expr {($rows - 2) * ($cols - 2)}]
    set aspectRatio [expr {1.0 * $cols / $rows}]

    return [list \
        pieces      $totalPieces \
        border      [expr {$totalPieces - $innerCount}] \
        inside      $innerCount \
        rows        $rows \
        columns     $cols \
        aspectRatio $aspectRatio \
        format      [expr {$aspectRatio == 1 ? "square" : ($aspectRatio < 1 ? "portrait" : "landscape")}] \
    ]
}

proc matchesCriteria {layout criteriaDict} {
    dict for {key val} $layout {
        if {[dict exists $criteriaDict $key] && $val != [dict get $criteriaDict $key]} {
            return false
        }
    }
    return true
}
