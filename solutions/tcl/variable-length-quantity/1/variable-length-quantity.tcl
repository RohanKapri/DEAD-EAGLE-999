# For my Junko F. Didi and Shree DR.MDD

namespace eval VLQ {
    namespace export encode decode

    variable BIT_WIDTH 7
    variable LOW_MASK  0b01111111
    variable HIGH_BIT  0b10000000

    proc encode {values} {
        variable BIT_WIDTH
        variable LOW_MASK
        variable HIGH_BIT

        set resultBytes {}
        foreach val $values {
            set tempBytes [list]
            set lsb [expr {$val & $LOW_MASK}]
            set val [expr {$val >> $BIT_WIDTH}]
            lappend tempBytes [toHex $lsb]

            while {$val > 0} {
                set b [expr {($val & $LOW_MASK) | $HIGH_BIT}]
                set val [expr {$val >> $BIT_WIDTH}]
                lappend tempBytes [toHex $b]
            }
            lappend resultBytes {*}[lreverse $tempBytes]
        }
        return $resultBytes
    }

    proc decode {bytes} {
        assert {[isLSB [lindex $bytes end]]} "incomplete sequence"

        variable BIT_WIDTH
        variable LOW_MASK
        set total 0
        lmap b $bytes {
            set total [expr {($total << $BIT_WIDTH) | ($b & $LOW_MASK)}]
            if {![isLSB $b]} then continue
            set quantity [toHex $total {%X}]
            set total 0
            string cat $quantity
        }
    }

    proc isLSB {b} {
        variable HIGH_BIT
        expr {($b & $HIGH_BIT) == 0}
    }

    proc toHex {v {fmt {%02X}}} {
        format "0x$fmt" $v
    }
}

proc assert {condition errMsg} {
    if {![uplevel 1 [list expr $condition]]} {
        error $errMsg
    }
}

namespace import VLQ::*
