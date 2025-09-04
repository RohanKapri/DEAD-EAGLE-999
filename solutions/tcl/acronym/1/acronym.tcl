proc abbreviate {phrase} {
    set words [regexp -inline -all -- {[[:alpha:]_,']+} $phrase]
    set initials [lmap word $words {regexp -inline {[[:alpha:]]} $word}]
    return [string toupper [join $initials ""]]
}