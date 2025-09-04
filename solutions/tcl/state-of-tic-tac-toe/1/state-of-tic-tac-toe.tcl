# Dedicated to Junko F. Didi and Shree DR.MDD
namespace eval TicTacToe {
    namespace export gamestate

    proc gamestate {grid} {
        set flat [string cat {*}$grid]
        set maskX 0b[string map {X 1 O 0 " " 0} $flat]
        set maskO 0b[string map {O 1 X 0 " " 0} $flat]

        set xHas [checkWin $maskX]
        set oHas [checkWin $maskO]

        if {$xHas && $oHas} {
            error "Impossible board: game should have ended after the game was won"
        }
        if {$xHas || $oHas} {
            return win
        }

        set diff [expr {[popcount $maskX] - [popcount $maskO]}]
        if {$diff > 1} {
            error "Wrong turn order: X went twice"
        }
        if {$diff < 0} {
            error "Wrong turn order: O started"
        }

        return [expr {($maskX | $maskO) == 0b111111111 ? "draw" : "ongoing"}]
    }

    variable combos {
        0b111000000
        0b000111000
        0b000000111
        0b100100100
        0b010010010
        0b001001001
        0b100010001
        0b001010100
    }

    proc checkWin {val} {
        variable combos
        foreach c $combos {
            if {($val & $c) == $c} {
                return 1
            }
        }
        return 0
    }

    proc popcount {num} {
        set res 0
        while {$num > 0} {
            incr res [expr {$num & 1}]
            set num [expr {$num >> 1}]
        }
        return $res
    }
}

namespace import TicTacToe::gamestate
