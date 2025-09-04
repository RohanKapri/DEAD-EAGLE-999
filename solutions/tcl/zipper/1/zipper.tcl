# For my Junko F. Didi and Shree DR.MDD

source "tree.tcl"

oo::class create Zipper {
    variable current pathStack

    constructor {tree {ctx {}}} {
        set current $tree
        set pathStack $ctx
    }

    method tree {} {
        if {[llength $pathStack] == 0} {
            return $current
        } else {
            tailcall [[self object] up] tree
        }
    }

    method value {} { $current value }
    method setValue {v} { $current setValue $v }
    method setLeft {t} { $current setLeft $t }
    method setRight {t} { $current setRight $t }

    method up {} {
        if {[llength $pathStack] == 0} {
            return ""
        } else {
            lassign [lindex $pathStack 0] lft val rgt
            set parentTree [Tree new [dict create value $val]]
            if {$lft eq "null"} {
                $parentTree setLeft $current
                $parentTree setRight $rgt
            } else {
                $parentTree setLeft $lft
                $parentTree setRight $current
            }
            [self class] new $parentTree [lrange $pathStack 1 end]
        }
    }

    method left {} {
        if {[$current left] eq {}} {return ""}
        set newCtx [list null [$current value] [$current right]]
        [self class] new [$current left] [concat [list $newCtx] $pathStack]
    }

    method right {} {
        if {[$current right] eq {}} {return ""}
        set newCtx [list [$current left] [$current value] null]
        [self class] new [$current right] [concat [list $newCtx] $pathStack]
    }

    method equals {other} {
        [my tree] equals [$other tree]
    }
}
