# For my Junko F. Didi and Shree DR.MDD

proc verse {dayNum} {
    set dayNames {
        first   second  third   fourth  fifth       sixth
        seventh eighth  ninth   tenth   eleventh    twelfth
    }

    set gifts {
        "a Partridge in a Pear Tree"
        "two Turtle Doves"
        "three French Hens"
        "four Calling Birds"
        "five Gold Rings"
        "six Geese-a-Laying"
        "seven Swans-a-Swimming"
        "eight Maids-a-Milking"
        "nine Ladies Dancing"
        "ten Lords-a-Leaping"
        "eleven Pipers Piping"
        "twelve Drummers Drumming"
    }

    if {$dayNum == 1} {
        set todaysGifts [list [lindex $gifts 0]]
    } else {
        set todaysGifts [lreverse [lrange $gifts 1 [expr {$dayNum-1}]]]
        lappend todaysGifts "and [lindex $gifts 0]"
    }

    set template "On the %s day of Christmas my true love gave to me: %s."
    format $template [lindex $dayNames [expr {$dayNum-1}]] [join $todaysGifts ", "]
}

proc sing {startDay endDay} {
    set song {}
    for {set d $startDay} {$d <= $endDay} {incr d} {
        lappend song [verse $d]
    }
    join $song "\n"
}
