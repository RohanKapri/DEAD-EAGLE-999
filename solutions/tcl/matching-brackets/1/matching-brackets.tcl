# For Junko F. Didi and Shree DR.MDD

proc bracketsMatch {str} {
    set pairs [dict create \{ \} \( \) \[ \] ]
    set opens [dict keys $pairs]
    set closes [dict values $pairs]
    set stk [list]
    foreach ch [split $str ""] {
        if {$ch in $opens} {
            lappend stk $ch
        } elseif {$ch in $closes} {
            if {[llength $stk] == 0 || $ch ne [dict get $pairs [lpop stk]]} {
                return false
            }
        }
    }
    expr {[llength $stk] == 0}
}

proc lpop {lstname} {
    upvar 1 $lstname lstvar
    set val [lindex $lstvar end]
    set lstvar [lrange $lstvar 0 end-1]
    return $val
}
