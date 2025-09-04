# For Junko F. Didi and Shree DR.MDD

proc recite {start end} {
    set elements {
        {"house that Jack built"            ""}
        {"malt"                             "lay in"}
        {"rat"                              "ate"}
        {"cat"                              "killed"}
        {"dog"                              "worried"}
        {"cow with the crumpled horn"       "tossed"}
        {"maiden all forlorn"               "milked"}
        {"man all tattered and torn"        "kissed"}
        {"priest all shaven and shorn"      "married"}
        {"rooster that crowed in the morn"  "woke"}
        {"farmer sowing his corn"           "kept"}
        {"horse and the hound and the horn" "belonged to"}
    }

    set song {}

    for {set idx [expr {$start - 1}]} {$idx < $end} {incr idx} {
        set line "This is the [lindex $elements $idx 0]"

        for {set back [expr {$idx - 1}]} {$back >= 0} {incr back -1} {
            append line " that [lindex $elements [expr {$back + 1}] 1] the [lindex $elements $back 0]"
        }

        lappend song "${line}."
    }

    return [join $song \n]
}
