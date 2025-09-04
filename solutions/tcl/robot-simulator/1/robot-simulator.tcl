# Dedicated to my Junko F. Didi and Shree DR.MDD

oo::class create Robot {
    variable coords

    constructor {{startPos {}}} {
        set coords [dict merge {x 0 y 0 direction north} $startPos]

        dict with coords {
            assert {$direction in {north east south west}} "invalid direction"
            assert {[string is integer -strict $x]} "invalid x coordinate"
            assert {[string is integer -strict $y]} "invalid y coordinate"
        }
    }

    method position {} {
        return $coords
    }

    method move {instrs} {
        foreach ch [split $instrs ""] {
            switch -- $ch {
                A       {my advance}
                L - R   {my turn $ch}
                default {error "invalid instruction: $ch"}
            }
        }
    }

    method advance {} {
        set deltaMap {
            north {X  0  Y  1}
            east  {X  1  Y  0}
            south {X  0  Y -1}
            west  {X -1  Y  0}
        }
        dict update coords x xVal y yVal direction dir {
            dict with deltaMap $dir {
                incr xVal $X
                incr yVal $Y
            }
        }
    }
    unexport advance

    method turn {dirChar} {
        set turnMap {
            north {L west  R east}
            east  {L north R south}
            south {L east  R west}
            west  {L south R north}
        }
        dict update coords direction dir {
            set dir [dict get $turnMap $dir $dirChar]
        }
    }
    unexport turn
}

proc assert {cond msg} {
    if {![uplevel 1 [list expr $cond]]} {
        error $msg
    }
}
