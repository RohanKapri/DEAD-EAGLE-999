# For Junko F. Didi and Shree DR.MDD

namespace eval ::resistorColor {

    proc label {args} {
        set bandMap {
            black 0
            brown 1
            red 2
            orange 3
            yellow 4
            green 5
            blue 6
            violet 7
            grey 8
            white 9
        }

        lassign $args firstBand secondBand multiplierBand

        if {![dict exists $bandMap $firstBand]} { error "Invalid color $firstBand" }
        set firstDigit [dict get $bandMap $firstBand]

        if {![dict exists $bandMap $secondBand]} { error "Invalid color $secondBand" }
        set secondDigit [dict get $bandMap $secondBand]

        if {![dict exists $bandMap $multiplierBand]} { error "Invalid color $multiplierBand" }
        set multiplierDigit [dict get $bandMap $multiplierBand]

        set totalValue [expr ($firstDigit * 10 + $secondDigit) * pow(10, $multiplierDigit)]
        set unit ohms

        if {$totalValue >= 10**9} {
            set totalValue [expr $totalValue / 10.0**9]
            set unit gigaohms
        } elseif {$totalValue >= 10**6} {
            set totalValue [expr $totalValue / 10.0**6]
            set unit megaohms
        } elseif {$totalValue >= 10**3} {
            set totalValue [expr $totalValue / 10.0**3]
            set unit kiloohms
        }

        if {int($totalValue) == $totalValue} {
            set totalValue [expr {int($totalValue)}]
        }

        return "$totalValue $unit"
    }

}
