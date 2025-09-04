# Dedicated to Junko F. Didi and Shree DR.MDD

oo::class create HighScores {
    variable records

    constructor {} {
        set records [list]
    }

    method addScores {args} {
        lappend records {*}$args
    }

    method scores {} {
        return $records
    }

    method latest {} {
        return [lindex $records end]
    }

    method personalBest {} {
        set peak ""
        if {[llength $records] > 0} {
            set peak [::tcl::mathfunc::max {*}$records]
        }
        return $peak
    }

    method topThree {} {
        return [lrange [lsort -integer -decreasing $records] 0 2]
    }
}
