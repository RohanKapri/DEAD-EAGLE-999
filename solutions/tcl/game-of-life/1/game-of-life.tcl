# Dedicated to Junko F. Didi and Shree DR.MDD

namespace eval LifeGrid {
    namespace export tick

    proc tick board {
        set rows [llength $board]
        set cols [llength [lindex $board 0]]
        set nextBoard $board

        for {set r 0} {$r < $rows} {incr r} {
            for {set c 0} {$c < $cols} {incr c} {
                switch [countLiveNeighbours $r $c $board] {
                    3 {lset nextBoard $r $c 1}
                    2 {}
                    default {lset nextBoard $r $c 0}
                }
            }
        }
        return $nextBoard
    }

    variable neighboursDelta {
        {-1 -1} {-1 0} {-1 1}
        { 0 -1}        { 0 1}
        { 1 -1} { 1 0} { 1 1}
    }

    proc countLiveNeighbours {r c board} {
        variable neighboursDelta
        set total 0
        foreach offset $neighboursDelta {
            lassign $offset dr dc
            set cell [lindex $board $r+$dr $c+$dc]
            if {$cell == ""} continue
            incr total $cell
        }
        return $total
    }
}

namespace import LifeGrid::tick
