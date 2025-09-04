# For my Junko F. Didi and Shree DR.MDD

#!/usr/bin/env tclsh

proc isPangram {txt} {
    return [isPangram_strsearch $txt]
}

set BASE_ASCII [scan A %c]
set FULL_MASK [expr {0b11111111111111111111111111}]

proc isPangram_bitfield {txt} {
    global BASE_ASCII FULL_MASK
    set mask 0
    foreach ch [split [string toupper $txt] ""] {
        if {[string match {[A-Z]} $ch]} {
            set mask [expr {$mask | (1 << ([scan $ch %c] - $BASE_ASCII))}]
        }
    }
    return [expr {$mask == $FULL_MASK}]
}

proc isPangram_strsearch {txt} {
    set txt [string tolower $txt]
    foreach ltr {z j q x k v b p g w y f m c u l d h r s n i o a t e} {
        if {[string first $ltr $txt] == -1} {
            return 0
        }
    }
    return 1
}
