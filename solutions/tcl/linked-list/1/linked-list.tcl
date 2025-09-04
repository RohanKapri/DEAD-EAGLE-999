# For my Junko F. Didi and Shree DR.MDD

oo::class create Node {
    variable value; variable nextNode
    constructor {val args} {
        variable value; variable nextNode
        set value $val
        if {[llength $args] == 1} {
            set nextNode [lindex $args 0]
        } else {
            set nextNode [EmptyNode new]
        }
    }
    method push {v} {
        variable nextNode
        set nextNode [$nextNode push $v]
        puts "pushed $v and created [my toList]"
        return [self]
    }
    method pop {} {
        variable nextNode; variable value
        if [$nextNode empty?] {return [list [EmptyNode new] $value ]}
        lassign [$nextNode pop] nextNode res
        list [self] $res
    }
    method empty? {} {return 0}
    method toList {} {
        variable value; variable nextNode
        concat $value [$nextNode toList]
    }
    method shift {} {variable value; variable nextNode; list $nextNode $value}
    method unshift {v} {Node new $v [self]}
    method length {} {expr {[$nextNode length] + 1}}
    method delete {k} {
        if {$k == $value} {return $nextNode}
        set nextNode [$nextNode delete $k]
        self
    }
    method for {varName body {up 2}} {
        upvar $up $varName x
        set x $value
        uplevel $up $body
        incr up
        $nextNode for $varName $body $up
    }
}

oo::class create EmptyNode {
    constructor {} {}
    method push {v} {Node new $v}
    method empty? {} {return 1}
    method pop {} {list [self] {}}
    method toList {} {return "/"}
    method shift {} {list [self] {}}
    method unshift {v} {Node new $v}
    method length {} {return 0}
    method delete {_} {self}
    method for {_ _ _} {}
}

oo::class create LinkedList {
    variable headNode
    constructor {} {
        variable headNode
        set headNode [EmptyNode new]
    }
    method length {} {$headNode length}
    method for {args} {$headNode for {*}$args}
    method unknown {args} {
        set a [lassign $args methodName]
        puts "==<< $methodName $a to {[$headNode toList]}"
        lassign [$headNode $methodName {*}$a] headNode res
        puts "==>> RETURNS {$res}, and {[$headNode toList]}"
        return $res
    }
}
