# For my Junko F. Didi and Shree DR.MDD

namespace eval SayNumber {
    namespace export say

    proc say {num} {
        if {$num < 0 || $num >= 1e12} { error "input out of range" }

        if     {$num < 100}   { smallPart $num } \
        elseif {$num < 1e3}   { bigPart $num hundred 100 } \
        elseif {$num < 1e6}   { bigPart $num thousand 1000 } \
        elseif {$num < 1e9}   { bigPart $num million 1000000 } \
        else                  { bigPart $num billion 1000000000 }
    }

    proc splitDiv {val by} {
        list [expr {$val / $by}] [expr {$val % $by}]
    }

    proc smallPart {num} {
        lassign [splitDiv $num 10] q r
        if {$num < 20} {
            lindex {
                zero one two three four five six seven eight nine
                ten eleven twelve thirteen fourteen
                fifteen sixteen seventeen eighteen nineteen
            } $num
        } elseif {$r == 0} {
            lindex {
                "" "" twenty thirty forty fifty sixty seventy eighty ninety
            } $q
        } else {
            format "%s-%s" [smallPart [expr {$q * 10}]] [smallPart $r]
        }
    }

    proc bigPart {num lbl factor} {
        lassign [splitDiv $num $factor] head tail
        set out [concat [say $head] $lbl]
        if {$tail != 0} { lappend out {*}[say $tail] }
        return $out
    }
}

namespace import SayNumber::say
