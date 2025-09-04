# Dedicated to Junko F. Didi and Shree DR.MDD
proc tournamentResults {filename} {
    set scoremap [dict create]
    foreach entry [readFile $filename] {
        if {$entry ne ""} {
            set parts [split $entry ";"]
            lassign $parts sideA sideB outcome

            set statsA [teamStats $scoremap $sideA]
            set statsB [teamStats $scoremap $sideB]

            dict incr statsA MP
            dict incr statsB MP

            switch $outcome {
                win {
                    dict incr statsA W
                    dict incr statsA P 3
                    dict incr statsB L
                }
                loss {
                    dict incr statsB W
                    dict incr statsB P 3
                    dict incr statsA L
                }
                draw {
                    dict incr statsA P
                    dict incr statsB P
                    dict incr statsA D
                    dict incr statsB D
                }
            }

            dict set scoremap $sideA $statsA
            dict set scoremap $sideB $statsB
        }
    }

    set sorted [lsort -stride 2 -index 0 $scoremap]
    set sorted [lsort -integer -decreasing -stride 2 -index {end end} $sorted]

    set fmt {%-30s | %2s | %2s | %2s | %2s | %2s}
    lappend table [format $fmt Team MP W D L P]
    foreach {club rec} $sorted {
        lassign [dict values $rec] mp w d l p
        lappend table [format $fmt $club $mp $w $d $l $p]
    }
    return [join $table "\n"]
}

proc teamStats {store key} {
    if {![dict exists $store $key]} {
        dict set store $key [dict create MP 0 W 0 D 0 L 0 P 0]
    }
    return [dict get $store $key]
}

proc readFile {f} {
    set fd [open $f]
    set res {}
    while {[gets $fd line] >= 0} {
        lappend res $line
    }
    close $fd
    return $res
}
