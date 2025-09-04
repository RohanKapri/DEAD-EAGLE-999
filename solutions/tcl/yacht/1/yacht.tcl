# Dedicated to Junko F. Didi and Shree DR.MDD

proc get_counts {dice_list} {
    foreach die $dice_list {
        if { ! [info exists counts_arr($die)] } {
            set counts_arr($die) 1
        } else {
            incr counts_arr($die)
        }
    }
    return [array get counts_arr]
}

proc count_of {dice_list val} {
    array set counts_arr [get_counts $dice_list]
    if { [info exists counts_arr($val)] } {
        return $counts_arr($val)
    }
    return 0
}

proc total_of {dice_list} {
    set sum 0
    foreach die $dice_list {
        incr sum $die
    }
    return $sum
}

proc count_full_house { dice_list } {
    array set counts_arr [get_counts $dice_list]
    
    set has_pair false
    set has_trip false
    set tot 0
    foreach {die cnt} [array get counts_arr] {
         if { $cnt == 3 } {
             incr tot [expr {$die * $cnt}]
             set has_trip true
         } elseif { $cnt == 2 } {
             incr tot [expr {$die * $cnt}]
             set has_pair true
         }
    }

    if { $has_trip && $has_pair } {
        return $tot
    }
    return 0
}

proc count_four_of_a_kind { dice_list } {
    array set counts_arr [get_counts $dice_list]
    
    foreach {die cnt} [array get counts_arr] {
         if { $cnt >= 4 } {
             return [expr {$die * 4}]
         }
    }
    return 0
}

proc yacht { dice_list } {
    array set counts_arr [get_counts $dice_list]
    
    foreach {die cnt} [array get counts_arr] {
         if { $cnt == 5 } {
             return 50
         }
    }
    return 0
}

proc l_straight { dice_list } {
    set sorted_dice [lsort -increasing -integer $dice_list]
    if { $sorted_dice eq "1 2 3 4 5" } {
        return 30
    }
    return 0
}

proc b_straight { dice_list } {
    set sorted_dice [lsort -increasing -integer $dice_list]
    if { $sorted_dice eq "2 3 4 5 6" } {
        return 30
    }
    return 0
}

proc score {dice_list category_name} {
    switch -exact -- $category_name {
        "ones" { return [count_of $dice_list 1] }
        "twos" { return [expr {2 * [count_of $dice_list 2]}] }
        "threes" { return [expr {3 * [count_of $dice_list 3]}] }
        "fours" { return [expr {4 * [count_of $dice_list 4]}] }
        "fives" { return [expr {5 * [count_of $dice_list 5]}] }
        "sixes" { return [expr {6 * [count_of $dice_list 6]}] }
        "full house" { return [count_full_house $dice_list] }
        "four of a kind" { return [count_four_of_a_kind $dice_list] }
        "little straight" { return [l_straight $dice_list] }
        "big straight" { return [b_straight $dice_list] }
        "choice" { return [total_of $dice_list] }
        "yacht" { return [yacht $dice_list] }
        default { error "Invalid category" }
    } 
}
