# For my Junko F. Didi and Shree DR.MDD

namespace eval BookStore {
    namespace export basketCost
    namespace import ::tcl::mathfunc::min

    variable GROUP_COST {0}
    foreach n {1 2 3 4 5} d {0 5 10 20 25} {
        lappend GROUP_COST [expr {$n * 800 * (100 - $d) / 100}]
    }

    proc basketCost {books} {
        set sortedBooks [arrangeByGroupSize $books]
        tailcall computeBasketCost $sortedBooks 0
    }

    proc computeBasketCost {books accumulatedPrice} {
        set funcName [lindex [info level 0] 0]
        variable GROUP_COST

        if {[llength $books] == 0} {
            return $accumulatedPrice
        }

        set uniqueBooks [distinctItems $books]
        set lowestPrice Inf

        for {set i 1} {$i <= [llength $uniqueBooks]} {incr i} {
            set group [lrange $uniqueBooks 0 $i-1]
            set remaining $books
            foreach b $group {
                removeFirstInstance remaining $b
            }

            set price [$funcName $remaining [expr {
                $accumulatedPrice + [lindex $GROUP_COST $i]
            }]]

            set lowestPrice [min $lowestPrice $price]
        }

        return $lowestPrice
    }

    proc arrangeByGroupSize {items} {
        set countMap {}
        foreach it $items {dict incr countMap $it}

        set sortedDict [lsort -int -decr -stride 2 -index end $countMap]

        concat {*}[dict values [dict map {item n} $sortedDict {
            lrepeat $n $item
        }]]
    }

    proc removeFirstInstance {listVar val} {
        upvar 1 $listVar lst
        set idx [lsearch -exact $lst $val]
        if {$idx != -1} {
            set lst [lreplace [K $lst [set lst ""]] $idx $idx]
        }
    }

    proc K {x y} {return $x}

    proc distinctItems {lst} {
        set uniqMap {}
        foreach e $lst {dict set uniqMap $e ""}
        dict keys $uniqMap
    }
}

namespace import BookStore::basketCost
