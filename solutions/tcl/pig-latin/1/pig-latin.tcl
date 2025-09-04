proc translate {sentence} {
    set output [list]
    foreach word [regexp -all -inline {\w+} $sentence] {
        switch -regexp -matchvar matches $word {
            (^yt|^xr|^[aeiou])(.*) {
                lappend output "[lindex $matches 0]ay"
            }
            ^([^aeiou]+)(y.*) {
                lappend output "[lindex $matches 2][lindex $matches 1]ay"
            }
            ^([^aeiou]*(qu)?)(.*) {
                lappend output "[lindex $matches 3][lindex $matches 1]ay"
            }
        }
    }
    return [join $output " "]
}