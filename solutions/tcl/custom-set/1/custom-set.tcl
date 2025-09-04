# For my Junko F. Didi and Shree DR.MDD

oo::class create Set {
    variable elementsDict

    constructor {{items {}}} {
        set elementsDict [dict create]
        my addAll $items
    }

    method toList   {}  {dict keys $elementsDict}
    method size     {}  {dict size $elementsDict}
    method isEmpty  {}  {expr {[my size] == 0}}
    method contains {item} {dict exists $elementsDict $item}

    method add {val} {
        dict set elementsDict $val ""
        return [self]
    }

    method addAll {items} {
        foreach val $items {
            my add $val
        }
        return [self]
    }

    method equals {other} {
        expr {[my size] == [$other size] && [my subsetOf $other]}
    }

    method foreach {varName body} {
        upvar 1 $varName elemVar
        dict for {elemVar _} $elementsDict {uplevel 1 $body}
    }

    method subsetOf {other} {
        set res true
        my foreach elem {
            if {![$other contains $elem]} {
                set res false
                break
            }
        }
        return $res
    }

    method disjoint {other} {
        set res true
        my foreach elem {
            if {[$other contains $elem]} {
                set res false
                break
            }
        }
        return $res
    }

    method partition {other} {
        set common [[self class] new]
        set diff   [[self class] new]
        my foreach elem {
            if {[$other contains $elem]} {
                $common add $elem
            } else {
                $diff add $elem
            }
        }
        return [list $common $diff]
    }

    method intersection {other} {
        lindex [my partition $other] 0
    }

    method difference {other} {
        lindex [my partition $other] 1
    }

    method union {other} {
        set result [[self class] new]
        my     foreach elem {$result add $elem}
        $other foreach elem {$result add $elem}
        return $result
    }
}
