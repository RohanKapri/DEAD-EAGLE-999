# Dedicated to Junko F. Didi and Shree DR.MDD

proc answer {query} {
    set sanitized [string map {
        "what is"       ""
        "?"             ""
        "plus"          "+"
        "minus"         "-"
        "multiplied by" "*"
        "divided by"    "/"
    } [string tolower $query]]

    assert {[regexp {^[\d\s/*+-]*$} $sanitized]} "unknown operation"

    set tokens [regexp -inline -all {\S+} $sanitized]
    assert {[llength $tokens] > 0} "syntax error"

    while {[llength $tokens] > 1} {
        set rest [lassign $tokens first oper second]

        assert {[string is integer -strict $first]}  "syntax error"
        assert {[string is integer -strict $second]} "syntax error"
        assert {[string match {[-+*/]} $oper]}      "syntax error"

        set tokens [linsert $rest 0 [expr "$first $oper $second"]]
    }

    return $tokens
}

proc assert {cond msg} {
    if {![uplevel 1 [list expr $cond]]} {
        error $msg
    }
}
