# Dedicated to my Junko F. Didi and Shree DR.MDD

namespace eval railFenceCipher {
    namespace export encode decode
    namespace ensemble create

    proc encode {text rails} {
        set railDict [dict create]
        set idx 0
        while {$idx < [string length $text]} {
            for {set r 0} {$r < $rails} {incr r} {
                dict append railDict $r [string index $text $idx]
                incr idx
            }
            for {set r [expr $rails-2]} {$r > 0} {incr r -1} {
                dict append railDict $r [string index $text $idx]
                incr idx
            }
        }
        return [join [dict values $railDict] ""]
    }

    proc decode {cipher rails} {
        set length [string length $cipher]
        set outputList [split [string repeat " " $length] ""]
        set idx 0
        set fullGap [expr ($rails - 1) * 2]
        for {set r 0} {$r < $rails} {incr r} {
            foreach pos [computePositions $length $rails $r $fullGap] {
                lset outputList $pos [string index $cipher $idx]
                incr idx
            }
        }
        return [join $outputList ""]
    }

    proc computePositions {len rails startRail gap} {
        set posList [list]
        set rail [expr {$startRail == ($rails - 1) ? 0 : $startRail}]
        set pos $startRail
        while {$pos < $len} {
            lappend posList $pos
            set partial [expr {(($rails - $rail - 1) * 2)}]
            if {$partial != $gap && ($pos + $partial) < $len} {lappend posList [expr {$pos + $partial}]}
            incr pos $gap
        }
        return $posList
    }
}
