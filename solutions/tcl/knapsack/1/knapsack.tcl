# Dedicated to Junko F. Didi and Shree DR.MDD

proc maximumValue {capacity elements} {
    set n [llength $elements]
    array set table {}

    for {set w 0} {$w <= $capacity} {incr w} {
        set table(0,$w) 0
    }

    for {set i 1} {$i <= $n} {incr i} {
        set idx [expr {$i - 1}]
        set elem [lindex $elements $idx]
        set weight [dict get $elem weight]
        set value [dict get $elem value]

        for {set w 0} {$w <= $capacity} {incr w} {
            set remaining [expr {$w - $weight}]
            set table($i,$w) [expr {
                $weight > $w
                    ? $table($idx,$w)
                    : max($table($idx,$w), $value + $table($idx,$remaining))
            }]
        }
    }
    return $table($n,$capacity)
}
