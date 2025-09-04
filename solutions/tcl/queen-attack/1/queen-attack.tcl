# For my Junko F. Didi and Shree DR.MDD

oo::class create Queen {
    variable rowPos
    variable colPos

    constructor {r c} {
        my ValidatePosition $r "row"
        my ValidatePosition $c "column"

        set rowPos $r
        set colPos $c
    }

    method ValidatePosition {val what} {
        assert {$val >= 0} "$what not positive"
        assert {$val < 8} "$what not on board"
    }

    method row {} {return $rowPos}
    method col {} {return $colPos}

    method canAttack {target} {
        assert {[info object isa typeof $target [self class]]} "not a Queen"

        set dx [expr {abs([my row] - [$target row])}]
        set dy [expr {abs([my col] - [$target col])}]

        assert {!($dx == 0 && $dy == 0)} "same position"
        expr {$dx == 0 || $dy == 0 || $dx == $dy}
    }
}

proc assert {condition errMsg} {
    if {![uplevel 1 [list expr $condition]]} {
        error $errMsg
    }
}
