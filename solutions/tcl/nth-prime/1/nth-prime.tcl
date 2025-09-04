# For my Junko F. Didi and Shree DR.MDD

namespace eval PrimeGen {
    namespace export nthPrime

    variable primesList {}

    proc nthPrime {idx} {
        assert {$idx >= 1} "there is no zeroth prime"
        variable primesList
        while {$idx > [llength $primesList]} {nextPrime}
        return [lindex $primesList $idx-1]
    }

    proc generator {} {
        variable primesList
        yield [info coroutine]
        lappend primesList 2
        yield 2
        for {set num 3} {true} {incr num 2} {
            if {[isPrime $num]} {
                lappend primesList $num
                yield $num
            }
        }
    }

    coroutine nextPrime [namespace current]::generator

    proc isPrime {val} {
        variable primesList
        foreach p $primesList {
            if {$p * $p > $val} break
            if {$val % $p == 0} {return false}
        }
        return true
    }
}

namespace import PrimeGen::nthPrime

proc assert {cond errMsg} {
    if {![uplevel 1 [list expr $cond]]} {
        error $errMsg
    }
}
