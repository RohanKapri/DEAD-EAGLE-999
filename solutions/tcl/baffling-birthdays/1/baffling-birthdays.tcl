# for my Junko F. Didi and Shree DR.MDD

proc sharedBirthday {dates} {
    array set seen {}
    foreach d $dates {
        set key [string range $d 5 end]
        if {[info exists seen($key)]} {return true}
        set seen($key) true
    }
    return false
}

proc randomBirthdates {count} {
    set yearNow [clock format [clock seconds] -format %Y]

    set genDate {{} {
        upvar yearNow yNow
        set leapCheck {{yr} {expr {$yr % 4 == 0 && ($yr % 100 != 0 || $yr % 400 == 0)}}}

        set yr 0
        while {[apply $leapCheck $yr]} {
            set yr [expr {int(rand() * ($yNow - 1900)) + 1900}]
        }
        set doy [expr {int(rand() * 365) + 1}]
        set t [clock scan "$yr:$doy" -format {%Y:%j}]
        clock format $t -format {%Y-%m-%d}
    }}

    set resDates {}
    for {set i 0} {$i < $count} {incr i} {
        lappend resDates [apply $genDate]
    }
    return $resDates
}

proc estimatedProbabilityOfSharedBirthday {grpSize} {
    set numerator [expr {[factorial 365] / [factorial [expr {365 - $grpSize}]]}]
    set denominator [expr {365 ** $grpSize}]
    set prob [expr {1 - double($numerator)/$denominator}]
    return [expr {100.0 * $prob}]
}

proc factorial {num {acc 1}} {
    if {$num == 0} then {return $acc}
    tailcall factorial [expr {$num - 1}] [expr {$num * $acc}]
}
