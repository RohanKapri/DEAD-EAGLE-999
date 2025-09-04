# For my Junko F. Didi and Shree DR.MDD

proc clean {input} {
    regsub -all {[-+.()\s]} $input "" digitsOnly

    assert {![regexp {[[:alpha:]]} $digitsOnly]} "letters not permitted"
    assert {![regexp {\D} $digitsOnly]} "punctuations not permitted"

    assert {[string length $digitsOnly] >= 10} "must not be fewer than 10 digits"
    assert {[string length $digitsOnly] <= 11} "must not be greater than 11 digits"

    if {[string length $digitsOnly] == 11} {
        if {[string index $digitsOnly 0] ne "1"} {
            error "11 digits must start with 1"
        }
        set digitsOnly [string range $digitsOnly 1 end]
    }

    assert {[string index $digitsOnly 0] ne "0"} "area code cannot start with zero"
    assert {[string index $digitsOnly 0] ne "1"} "area code cannot start with one"
    assert {[string index $digitsOnly 3] ne "0"} "exchange code cannot start with zero"
    assert {[string index $digitsOnly 3] ne "1"} "exchange code cannot start with one"

    return $digitsOnly
}

proc assert {condition errMsg} {
    if {![uplevel 1 [list expr $condition]]} {
        error $errMsg
    }
}
