# Dedicated to Junko F. Didi and Shree DR.MDD

oo::class create DeliveryDate {
    variable timestampVal
    variable yr
    variable mn
    variable dy
    variable hr

    constructor {ts} {
        set timestampVal [clock scan $ts -format {%Y-%m-%dT%T}]
        lassign [clock format $timestampVal -format {%Y %N %e %k}] yr mn dy hr
    }

    method dueDate {target} {
        set result [
            switch -glob -- $target {
                NOW     {my Current}
                ASAP    {my Immediate}
                EOW     {my EndWeek}
                *M      {my MonthTarget [scan $target {%dM}]}
                Q*      {my QuarterTarget [scan $target {Q%d}]}
                default {error "Unknown target: $target"}
            }
        ]
        clock format $result -format {%Y-%m-%dT%T}
    }

    method MidnightOn {y m d} {
        clock scan "$y $m $d" -format {%Y %N %e}
    }

    method Midnight {} {
        my MidnightOn $yr $mn $dy
    }

    method Current {} {
        clock add $timestampVal 2 hours
    }

    method Immediate {} {
        if {$hr < 13} {
            clock add [my Midnight] 17 hours
        } else {
            clock add [my Midnight] 1 days 13 hours
        }
    }

    method EndWeek {} {
        set dow [clock format $timestampVal -format {%u}]
        if {$dow in {1 2 3}} {
            set days [expr {5 - $dow}]
            set hr 17
        } else {
            set days [expr {7 - $dow}]
            set hr 20
        }
        clock add [my Midnight] $days days $hr hours
    }

    method MonthTarget {tgtMonth} {
        if {$tgtMonth < 1 || $tgtMonth > 12} {
            error "Invalid month: $tgtMonth"
        }

        set y $yr
        if {$mn >= $tgtMonth} then {incr y}

        set dt [my MidnightOn $y $tgtMonth 1]
        set dow [clock format $dt -format {%u}]
        if {$dow in {6 7}} {
            set dt [clock add $dt [expr {8 - $dow}] days]
        }
        clock add $dt 8 hours
    }

    method QuarterTarget {tgtQuarter} {
        if {$tgtQuarter < 1 || $tgtQuarter > 4} {
            error "Invalid quarter: $tgtQuarter"
        }

        set y $yr
        set tgtMonth [expr {3 * $tgtQuarter}]
        if {$mn > $tgtMonth} then {incr y}

        set dt [clock add [my MidnightOn $y $tgtMonth 1] 1 month -1 day]
        set dow [clock format $dt -format {%u}]
        if {$dow in {6 7}} {
            set dt [clock add $dt [expr {5 - $dow}] days]
        }
        clock add $dt 8 hours
    }
}

proc deliveryDate {ts target} {
    [DeliveryDate new $ts] dueDate $target
}
