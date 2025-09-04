oo::class create BinarySearchTree {
    variable data
    variable left
    variable right

    constructor {} {
      foreach x {data left right} {variable $x; set $x {}}
    }

    method insert {value} {
        foreach x {data left right} {variable $x}
        if [string equal {} $data] {set data $value; return}
        set name [expr {$value <= $data ? {left} : {right}}]
        set node [subst $$name]
        if [string equal $node {}] {
          set node [set $name [BinarySearchTree new]]
          puts "ew node: $node"
        }
        $node insert $value
    }

    method data {} {variable data; return $data}

    method toDict {} {
        foreach x {data left right} {variable $x}
        set l [expr {[string match ?* $left] ? [$left toDict] : {}}]
        set r [expr {[string match ?* $right] ? [$right toDict] : {}}]
        return [list data $data left $l right $r]
    }

    method inorder {} {
        foreach x {data left right} {variable $x}
        set out {}
        if {!($left eq {})} { lappend out {*}[$left inorder] }
        if {!($data eq {})} { lappend out $data }
        if {!($right eq {})} { lappend out {*}[$right inorder] }
        return $out
    }

    method sorted {} {
        my inorder
    }

    method map {name body} {
        if {!($data eq {})} { set data [apply [list $name $body] [self]] }
        if {!($left eq {})} { $left map $name $body }
        if {!($right eq {})} { $right map $name $body }
        my inorder
    }
}