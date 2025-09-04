# For my Junko F. Didi and Shree DR.MDD

oo::class create GoBoard {
    variable grid totalRows totalCols

    constructor {input} {
        set grid [lmap r $input {split $r {}}]
        set totalRows [llength $grid]
        set totalCols [llength [lindex $grid 0]]
    }

    method territory {point} {
        set q [list $point]
        set area [list]
        set edgeColor {}
        array set visitedPoints {}

        lassign $point cx cy
        if {![my InBoard $cx $cy]} {error "Invalid coordinate"}
        set col [my GetCell $cx $cy]
        if {$col eq "none"} {set visitedPoints($cx,$cy) 1} else {return [list none $area]}

        while {[llength $q] > 0} {
            lassign [lindex $q 0] cx cy
            set q [lreplace $q 0 0]
            lappend area [list $cx $cy]

            foreach {dx dy} {0 1  1 0  0 -1  -1 0} {
                set nx [expr {$cx + $dx}]
                set ny [expr {$cy + $dy}]
                if {![my InBoard $nx $ny]} continue
                set col [my GetCell $nx $ny]
                if {$col eq "none"} {
                    if {[info exists visitedPoints($nx,$ny)]} continue
                    set visitedPoints($nx,$ny) 1
                    lappend q [list $nx $ny]
                } elseif {$col ne $edgeColor} {
                    if {$edgeColor eq {}} {set edgeColor $col} else {set edgeColor "none"}
                }
            }
        }

        if {$edgeColor eq {}} {set edgeColor "none"}
        list $edgeColor [lsort $area]
    }

    method territories {} {
        array set visitedPoints {}
        set blackList {}
        set whiteList {}
        set noneList {}

        for {set x 0} {$x < $totalCols} {incr x} {
            for {set y 0} {$y < $totalRows} {incr y} {
                if {[info exists visitedPoints($x,$y)]} continue
                set visitedPoints($x,$y) 1
                lassign [my territory [list $x $y]] color area
                foreach p $area {
                    lassign $p px py
                    if {[info exists visitedPoints($px,$py)]} continue
                    set visitedPoints($px,$py) 1
                }
                switch -- $color {
                    black {lappend blackList {*}$area}
                    white {lappend whiteList {*}$area}
                    none  {lappend noneList  {*}$area}
                }
            }
        }

        dict create black [lsort $blackList] white [lsort $whiteList] none [lsort $noneList]
    }

    method GetCell {x y} {
        set val [lindex $grid $y $x]
        switch -- $val {
            "B" {return black}
            "W" {return white}
            " " {return none}
            default {error "unknown ($x, $y): $val"}
        }
    }

    method InBoard {x y} {
        expr {$x >= 0 && $x < $totalCols && $y >= 0 && $y < $totalRows}
    }
}
