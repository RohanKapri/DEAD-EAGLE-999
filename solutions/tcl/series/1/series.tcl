proc slices {series length} {
    if {$length < 1} {
        return -code error "slice length cannot be less than one"
    }
    set series_len [string length $series]
    if {$series_len == 0} {
        return -code error "series cannot be empty"
    }
    if {$length > $series_len} {
        return -code error "slice length cannot be greater than series length"
    }
    set result {}
    for {set i 0; set j $length} {$j <= $series_len} {incr i; incr j} {
        lappend result [string range $series $i $j-1]
    }
    return $result
}