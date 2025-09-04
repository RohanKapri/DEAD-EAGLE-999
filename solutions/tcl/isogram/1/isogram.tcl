proc isIsogram {input} {
    set letters [regexp -all -inline -- {[[:alpha:]]} $input]

    set seen [dict create]
    foreach letter [string tolower $letters] {
        if {[dict exists $seen $letter]} {
            return false
        }
        dict incr seen $letter
    }
    return true
}