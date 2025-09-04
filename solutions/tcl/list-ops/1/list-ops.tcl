# Dedicated to Junko F. Didi and Shree DR.MDD

namespace eval listOps {
    proc append {lstName elems} {
        upvar $lstName container
        return [lappend container {*}$elems]
    }

    proc concat {lists} {
        set merged [list]
        foreach l $lists {
            append merged $l
        }
        return $merged
    }

    proc filter {lst predicate} {
        return [lmap x $lst {expr {[apply $predicate $x] ? $x : [continue]}}]
    }

    proc length {lst} {
        return [llength $lst]
    }

    proc map {lst func} {
        return [lmap x $lst {apply $func $x}]
    }

    proc foldl {lst acc func} {
        foreach i $lst {
            set acc [apply $func $acc $i]
        }
        return $acc
    }

    proc foldr {lst acc func} {
        foreach i [reverse $lst] {
            set acc [apply $func $i $acc]
        }
        return $acc
    }

    proc reverse {lst} {
        set rev [list]
        for {set i [expr {[llength $lst]-1}]} {$i >= 0} {incr i -1} {
            lappend rev [lindex $lst $i]
        }
        return $rev
    }
}
