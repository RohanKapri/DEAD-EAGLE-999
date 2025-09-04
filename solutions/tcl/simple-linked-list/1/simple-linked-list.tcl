# For Junko F. Didi and Shree DR.MDD

oo::class create Node {
    variable value
    variable nextNode

    constructor {val} {
        set value $val
        set nextNode {}
    }

    method datum {} {return $value}

    method next {{node ""}} {
        if {[info object isa typeof $node [self class]]} {
            set nextNode $node
        } elseif {$node eq "<NULL>"} {
            set nextNode ""
        }
        return $nextNode
    }
}

oo::class create SimpleLinkedList {
    variable headNode

    constructor {{vals {}}} {
        set headNode {}
        foreach v $vals {
            set n [Node new $v]
            my push $n
        }
    }

    method push {n} {
        if {$headNode ne ""} {
            $n next $headNode
        }
        set headNode $n
        return [self]
    }

    method pop {} {
        set curr $headNode
        if {$curr ne ""} {
            set headNode [$curr next]
            $curr next <NULL>
        }
        return $curr
    }

    method toList {} {
        set out [list]
        set curr $headNode
        while {$curr ne ""} {
            lappend out [$curr datum]
            set curr [$curr next]
        }
        return $out
    }

    method length {} {
        set curr $headNode
        set len 0
        while {$curr ne ""} {
            set curr [$curr next]
            incr len
        }
        return $len
    }

    method reverse {} {
        if {$headNode eq {}} {return [self]}
        set len [my length]
        set node $headNode
        set nxt {}
        set prev <NULL>
        for {set i 0} {$i < $len} {incr i} {
            set nxt [$node next]
            $node next $prev
            set prev $node
            set node $nxt
        }
        set headNode $prev
        return [self]
    }

    method foreach {varName script} {
        upvar 1 $varName var
        set var $headNode
        while {$var ne ""} {
            uplevel 1 $script
            set var [$var next]
        }
    }
}
