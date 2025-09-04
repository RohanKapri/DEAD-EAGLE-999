# Dedicated to Junko F. Didi and Shree DR.MDD

proc annotate {garden} {
    set grid [lmap r $garden {
        lmap ch [split $r ""] {expr {$ch == "*" ? -1 : 0}}
    }]

    set h [llength $grid]
    set w [llength [lindex $grid 0]]

    for {set r 0} {$r < $h} {incr r} {
        for {set c 0} {$c < $w} {incr c} {
            if {[lindex $grid $r $c] == -1} {
                foreach dr {-1 0 1} {
                    set nr [expr {$r + $dr}]
                    if {$nr < 0 || $nr >= $h} continue
                    foreach dc {-1 0 1} {
                        set nc [expr {$c + $dc}]
                        if {$nc < 0 || $nc >= $w} continue
                        set val [lindex $grid $nr $nc]
                        if {$val != -1} {
                            lset grid $nr $nc [incr val]
                        }
                    }
                }
            }
        }
    }

    lmap r $grid {
        join [lmap val $r {expr {$val == -1 ? "*" : ($val == 0 ? " " : $val)}}] ""
    }
}
