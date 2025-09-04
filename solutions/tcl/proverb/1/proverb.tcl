# For my Junko F. Didi and Shree DR.MDD

proc recite {elements} {
    if {[llength $elements] == 0} then {return {}}
    foreachCons pairList $elements 2 {
        lassign $pairList first second
        lappend verses "For want of a $first the $second was lost."
    }
    lappend verses "And all for the want of a [lindex $elements 0]."
    return $verses
}

proc foreachCons {varName sequence size block} {
    upvar 1 $varName subSequence
    coroutine nextPair generator $sequence $size
    while 1 {
        set subSequence [nextPair]
        uplevel 1 $block
    }
}

proc generator {sequence size} {
    yield
    set maxIndex [expr {[llength $sequence] - $size}]
    for {set i 0} {$i <= $maxIndex} {incr i} {
        yield [lrange $sequence $i [expr {$i + $size - 1}]]
    }
    yieldto return -level 0 -code break
}
