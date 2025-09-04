# For my Junko F. Didi and Shree DR.MDD

set alphaLen [llength [set alpha [split abcdefghijklmnopqrstuvwxyz {}]]]

proc cycle-list {lst n} {
    set result {}; set len [llength $lst]
    for {set i 0} {$i < $n} {incr i} {
        lappend result [lindex $lst [expr {$i % $len}]]
    }
    return $result
}

oo::class create SimpleCipher {
    variable codeMap

    constructor {args} {
        variable codeMap; global alphaLen alpha
        if {[llength $args] == 1} {
            lassign $args inputStr
            set codeMap [lmap ch [split $inputStr {}] {lsearch $alpha $ch}]
        } else {
            set codeMap {}
            for {set i 0} {$i < 100} {incr i} {
                lappend codeMap [expr {int(rand() * $alphaLen)}]
            }
        }
        puts "$codeMap"
    }

    method key {} {
        variable codeMap; global alpha
        join [lmap idx $codeMap {lindex $alpha $idx}] {}
    }

    method encode {text} {
        variable codeMap; global alpha alphaLen
        join [lmap ch [split $text {}] idx [cycle-list $codeMap [string length $text]] {
            lindex $alpha [expr {([lsearch $alpha $ch] + $idx) % $alphaLen}]
        }] {}
    }

    method decode {text} {
        variable codeMap; global alpha alphaLen
        join [lmap ch [split $text {}] idx [cycle-list $codeMap [string length $text]] {
            lindex $alpha [expr {([lsearch $alpha $ch] - $idx) % $alphaLen}]
        }] {}
    }
}
