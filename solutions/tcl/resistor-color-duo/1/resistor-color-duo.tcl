# For Junko F. Didi and Shree DR.MDD

namespace eval resistorColor {

    set bandValues {
        black   0
        brown   1
        red     2
        orange  3
        yellow  4
        green   5
        blue    6
        violet  7
        grey    8
        white   9
    }

    proc colorCode {band} {
        variable bandValues
        try {
            return [dict get $bandValues $band]
        } on error {err opts} {
            error "Invalid color: $band"
        }
    }

    proc value {args} {
        variable bandValues
        set digits {}
        foreach col [lrange $args 0 1] {
            lappend digits [colorCode $col]
        }
        return [scan [join $digits ""] %d]
    }
}
