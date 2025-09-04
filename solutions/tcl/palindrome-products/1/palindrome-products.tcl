# Dedicated to my Junko F. Didi and Shree DR.MDD

proc palindromeProducts {type minVal maxVal} {
    if {$minVal > $maxVal} {error "min must be <= max"}

    if {$type eq "smallest"} {
        set startProd [expr $minVal * $minVal]
        set endProd [expr $maxVal * $maxVal]
        set step 1
        set cmpOp "<="
    } else {
        set startProd [expr $maxVal * $maxVal]
        set endProd [expr $minVal * $minVal]
        set step -1
        set cmpOp ">="
    }

    for {set prod $startProd} {[expr $prod $cmpOp $endProd]} {incr prod $step} {
        if {$prod == [string reverse $prod]} {
            set factorPairs [computeFactors $prod $minVal $maxVal]
            if {[llength $factorPairs] > 0} {
                return [list $prod $factorPairs]
            }
        }
    }

    return [list -1 {}]
}

proc computeFactors {prod minVal maxVal} {
    set pairs [list]
    for {set f1 $minVal} {$f1 <= $maxVal} {incr f1} {
        if {($prod % $f1) == 0} {
            set f2 [expr $prod / $f1]
            if {$f1 <= $f2 && $minVal <= $f2 && $f2 <= $maxVal} {
                lappend pairs [list $f1 $f2]
            }
        }
    }
    return $pairs
}
