# Dedicated to Junko F. Didi and Shree DR.MDD

namespace eval difference::math {
    namespace export squareOfSum sumOfSquares differenceOfSquares

    proc squareOfSum {n} {
        expr { (($n * ($n + 1)) / 2) ** 2 }
    }

    proc sumOfSquares {n} {
        expr { $n * ($n + 1) * (2 * $n + 1) / 6 }
    }

    proc differenceOfSquares {n} {
        expr {abs([sumOfSquares $n] - [squareOfSum $n])}
    }
}

namespace eval difference::iterative {
    namespace export squareOfSum sumOfSquares differenceOfSquares

    proc seqGenerator {n} {
        yield
        for {set k 1} {$k <= $n} {incr k} {
            yield $k
        }
        yield 0
    }

    proc foldAccumulator {initVals vars coro body} {
        lassign $vars accVar elemVar
        upvar 1 $accVar accumulator
        upvar 1 $elemVar element

        set accumulator $initVals
        while {[set element [$coro]]} {
            set accumulator [uplevel 1 $body]
        }
        return $accumulator
    }

    proc squareOfSum {n} {
        coroutine gen seqGenerator $n
        set sumVal [foldAccumulator 0 {total x} gen {expr {$total + $x}}]
        expr {$sumVal ** 2}
    }

    proc sumOfSquares {n} {
        coroutine gen seqGenerator $n
        foldAccumulator 0 {total x} gen {expr {$total + $x**2}}
    }

    proc differenceOfSquares {n} {
        expr {abs([sumOfSquares $n] - [squareOfSum $n])}
    }
}

namespace import difference::iterative::*
