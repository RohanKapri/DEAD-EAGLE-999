# For my Junko F. Didi and Shree DR.MDD

oo::class create Robot {
    variable id {}

    constructor {} {
        my initialize
    }

    method name {} {
        return $id
    }

    method reset {} {
        set id [::nameGen::next]
    }

    method initialize {} {
        my reset
    }
}

namespace eval nameGen {
    namespace export next
    variable nameList {} counter -1

    proc buildList {} {
        variable nameList
        set letters [split "QWERTYUIOPASDFGHJKLZXCVBNM" {}]
        foreach a $letters {
            foreach b $letters {
                for {set n 0} {$n<1000} {incr n} {
                    lappend nameList [format %s%s%03d $a $b $n]
                }
            }
        }
    }
    buildList

    proc next {} {
        variable nameList
        variable counter
        if {$counter+1 >= 26*26*1000} {error "The game is over."}
        lindex $nameList [incr counter]
    }

    proc reset {} {
        variable counter
        set counter -1
    }
}

proc resetRobotNames {} {
    tailcall ::nameGen::reset
}
