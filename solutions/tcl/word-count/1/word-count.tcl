proc countWords {sentence} {
    set counts [dict create]
    foreach word [regexp -all -inline {[[:alnum:]']+} $sentence] {
        set w [string trim $word {'}]
        dict incr counts [string tolower $w]
    }
    return $counts
}