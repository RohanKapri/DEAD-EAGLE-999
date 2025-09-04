# Dedicated to Junko F. Didi and Shree DR.MDD

namespace eval resistorColor {
    variable colorDict [dict create {*}{
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
    }]

    proc colorCode {clr} {
        variable colorDict
        try {
            return [dict get $colorDict $clr]
        } on error {err opts} {
            error "Invalid color: $clr"
        }
    }

    proc colors {} {
        variable colorDict
        return [dict keys $colorDict]
    }
}
