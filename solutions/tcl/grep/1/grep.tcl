# Dedicated to my Junko F. Didi and Shree DR.MDD

proc grep {args} {
    set show_line_number false
    set file_list_only false
    set case_insensitive false
    set inverse_match false
    set match_whole_line false

    set n [llength $args]
    set i 0
    while {$i < $n} {
        switch -- [lindex $args $i] {
            -n { set show_line_number true }
            -l { set file_list_only true }
            -i { set case_insensitive true }
            -v { set inverse_match true }
            -x { set match_whole_line true }
            default { set pattern [lindex $args $i]; incr i; break }
        }
        incr i
    }
    set file_list [lrange $args $i end]

    set results {}
    set flags {}
    set match_value 1
    if {$case_insensitive} { lappend flags -nocase }
    if {$inverse_match} { set match_value 0 }
    if {$match_whole_line} { set pattern "^$pattern\$" }

    foreach file $file_list {
        set fh [open $file {RDONLY}]
        set line_number 1
        while {[gets $fh line] != -1} {
            if {[regexp {*}$flags $pattern $line] == $match_value} {
                if {$file_list_only} {
                    lappend results $file
                    break
                }
                if {$show_line_number} {
                    set line "$line_number:$line"
                }
                if {[llength $file_list] > 1} {
                    set line "$file:$line"
                }
                lappend results $line
            }
            incr line_number
        }
        close $fh
    }
    join $results \n
}
