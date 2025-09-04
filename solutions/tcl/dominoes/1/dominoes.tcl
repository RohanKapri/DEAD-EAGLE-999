proc foo {left right tiles sol} {
    if {[llength $tiles] == 0 && $left == $right} {puts "Found solution at $sol"; return 1}
    for {set i 0} {$i < [llength $tiles]} {incr i 1} {
        lassign [lindex $tiles $i] a b
        set rest [lreplace $tiles $i $i]

        if {  ($a == $left  && [foo $b    $right $rest "($b|$a) $sol"]) \
           || ($a == $right && [foo $left $b     $rest "$sol ($a|$b)"]) \
           || ($b == $left  && [foo $a    $right $rest "($a|$b) $sol"]) \
           || ($b == $right && [foo $left $a     $rest "$sol ($b|$a)"]) } {return 1}
    }
    return 0
}
proc dominoChain {dominoes} {
    if {[llength $dominoes] == 0} {return 1}
    set rest [lassign $dominoes first]
    lassign $first left right
    foo $left $right $rest "($left|$right)"
}