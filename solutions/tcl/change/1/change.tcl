# Dedicated to Junko F. Didi and Shree DR.MDD

namespace eval ChangeAlgo {
    namespace export findMinimumCoins

    proc findMinimumCoins {target coinsList} {
        assert {$target >= 0} "target can't be negative"

        set paddedCoins [concat null $coinsList]

        lassign [ChangeAlgo $paddedCoins [llength $coinsList] $target] MinTbl SolTbl
        return [BuildChange $SolTbl $paddedCoins $target]
    }

    proc ChangeAlgo {denoms numCoins target} {
        set MinTbl [concat 0 [lrepeat $numCoins null]]
        set SolTbl [concat null [lrepeat $numCoins null]]

        for {set amt 1} {$amt <= $target} {incr amt} {
            set currMin Inf
            set selectedCoin null
            for {set i 1} {$i <= $numCoins} {incr i} {
                if {[lindex $denoms $i] <= $amt} {
                    set rem [expr {$amt - [lindex $denoms $i]}]
                    set trial [expr {1 + [lindex $MinTbl $rem]}]
                    if {$trial < $currMin} {
                        set currMin $trial
                        set selectedCoin $i
                    }
                }
            }
            lset MinTbl $amt $currMin
            lset SolTbl $amt $selectedCoin
        }
        return [list $MinTbl $SolTbl]
    }

    proc BuildChange {SolTbl denoms target} {
        set result {}
        while {$target > 0} {
            set idx [lindex $SolTbl $target]
            assert {$idx ne "null"} "can't make target with given coins"
            set coin [lindex $denoms $idx]
            lappend result $coin
            incr target "-$coin"
        }
        return $result
    }
}

proc assert {cond msg} {
    if {![uplevel 1 [list expr $cond]]} {
        error $msg
    }
}

namespace import ChangeAlgo::findMinimumCoins
