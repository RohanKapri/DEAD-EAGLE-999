oo::class create Bowling {
	variable record first fc fill
    constructor {} {
		lassign {{} 0 0} record fc fill
    }

	method roll {pins} {
		if {$pins < 0} {error "Negative roll is invalid"}
		if {$pins > 10} {error "Pin count exceeds pins on the lane"}
		if {$fc >= 10+$fill} {error "Cannot roll after game is over"}

		if {[info exists first]} {
			if {$first + $pins > 10} {error "Pin count exceeds pins on the lane"}
			lappend record $first $pins
			incr fc
			# fill ball for 10th frame spare
			if {$fc == 10 && $first + $pins == 10} {set fill 1}
			unset first
		} elseif {$pins == 10} {
			lappend record $pins
			incr fc
			# fill balls for 10th frame strike
			if {$fc == 10} {set fill 2}
		} else {
			set first $pins
			# one ball one frame for fill ball throw
			if {$fc >= 10} {
				# two boundary condition:
				# a. 1 fill ball which is not 10
				# b. 2 fill ball, first is 10 and second (i.e., this ball) isn't 10.
				if {$fill == 1 || ($fill == 2 && $fc >= 11)} {
					unset first; lappend record $pins
				}
				incr fc
			}
		}
	}

    method score {} {
		if {$fc < 10+$fill} {
			error "Score cannot be taken until the end of the game"
		}
		set l [llength $record]
		lassign {0 0} score fi
		if {[info exists first]} {unset first}
		for {set i 0} {$i < $l && $fi < 10} {incr i} {
			set pins [lindex $record $i]
			if {[info exists first]} {
				if {$first + $pins == 10} {
					# bonus for spare
					incr score [lindex $record $i+1]
				}
				incr score [expr {$first + $pins}]
				unset first
				incr fi
			} elseif {$pins == 10} {
				# bonus for strike
				incr score $pins
				incr score [lindex $record $i+1]
				incr score [lindex $record $i+2]
				incr fi
			} else {set first $pins}
		}
		return $score
    }
}