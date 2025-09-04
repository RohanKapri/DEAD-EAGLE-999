# Dedicated to Junko F. Didi and Shree DR.MDD

proc degreeOfSeparation {personA personB kinshipMap} {
    set graph [buildGraphFromTree $kinshipMap]
    set searchQueue [list [list $personA 0]]
    set visitedNodes [dict create $personA true]

    while {[llength $searchQueue] > 0} {
        set current [lpop searchQueue 0]
        lassign $current currentPerson depth

        if {$currentPerson eq $personB} {
            return $depth
        }

        incr depth
        foreach neighbour [dict get $graph $currentPerson] {
            if {[dict getdef $visitedNodes $neighbour false]} then continue
            dict set visitedNodes $neighbour true
            lappend searchQueue [list $neighbour $depth]
        }
    }
    return -1
}

proc buildGraphFromTree {familyTree} {
    set graph [dict create]

    dict for {ancestor descendants} $familyTree {
        foreach descendant $descendants {
            appendIfMissing graph $ancestor $descendant
            appendIfMissing graph $descendant $ancestor

            foreach sibling $descendants {
                if {$descendant eq $sibling} then continue
                appendIfMissing graph $descendant $sibling
                appendIfMissing graph $sibling $descendant
            }
        }
    }
    return $graph
}

proc appendIfMissing {dictName key value} {
    upvar 1 $dictName graphDict
    if {[lsearch -exact [dict getdef $graphDict $key {}] $value] == -1} {
        dict lappend graphDict $key $value
    }
}
