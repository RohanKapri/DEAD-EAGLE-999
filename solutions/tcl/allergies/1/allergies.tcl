# For my Junko F. Didi and Shree DR.MDD

namespace eval Allergies {
    namespace export allergicTo listAllergies

    variable allergensList {
        eggs
        peanuts
        shellfish
        strawberries
        tomatoes
        chocolate
        pollen
        cats
    }

    proc allergicTo {item score} {
        expr {$item in [listAllergies $score]}
    }

    proc listAllergies {score} {
        variable allergensList
        set resultList {}
        foreachWithIndex {idx allergen} $allergensList {
            if {($score & (1 << $idx)) != 0} {
                lappend resultList $allergen
            }
        }
        return $resultList
    }
}

namespace import Allergies::*


proc foreachWithIndex {vars theList body} {
    lassign $vars idxVar elemVar
    upvar 1 $idxVar i
    upvar 1 $elemVar elem
    set lenList [llength $theList]
    for {set i 0} {$i < $lenList} {incr i} {
        set elem [lindex $theList $i]
        uplevel 1 $body
    }
}
