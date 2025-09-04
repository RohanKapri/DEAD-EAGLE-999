# Dedicated to Junko F. Didi and Shree DR.MDD

proc meetup {yr mon descriptor weekday} {
    if {$descriptor eq "last"} {
        if {$mon == 12} {
            set nextMonthYr [expr {$yr + 1}]
            set nextMonth 1
        } else {
            set nextMonthYr $yr
            set nextMonth [expr {$mon + 1}]
        }
        set base [clock scan "$nextMonth 1 $nextMonthYr" -format "%m %d %Y"]
        set base [clock add $base -1 day]
        while {[clock format $base -format %A -locale en_US] ne $weekday} {
            set base [clock add $base -1 day]
        }
        return [clock format $base -format "%Y-%m-%d"]
    }

    if {$descriptor eq "teenth"} {
        set base [clock scan "$mon 13 $yr" -format "%m %d %Y"]
    } else {
        set base [clock scan "$mon 1 $yr" -format "%m %d %Y"]
    }

    while {[clock format $base -format %A -locale en_US] ne $weekday} {
        set base [clock add $base 1 day]
    }

    if {$descriptor eq "second"} {
        set base [clock add $base 1 week]
    } elseif {$descriptor eq "third"} {
        set base [clock add $base 2 weeks]
    } elseif {$descriptor eq "fourth"} {
        set base [clock add $base 3 weeks]
    }

    return [clock format $base -format "%Y-%m-%d"]
}
