namespace eval Poker {
	namespace export bestHands
	variable ranks {
		high 0 pair 3 2pairs 6 3kind 7
		straight 8 flush 9 fullh 10
		4kind 11 sflush 13
	}
	proc bestHands {hands} {
		set res [list [lindex $hands 0]]
		set max [handVals [lindex $hands 0]]
		foreach hand [lrange $hands 1 end] {
			set vals [handVals $hand]
			set cmp [cmpHandVals $vals $max]
			if {$cmp == 1} {
				set res [list $hand]
				set max $vals
			} elseif {$cmp == 0} {
				lappend res $hand
			}
		}
		return $res
	}
	proc cmpHandVals {hand1 hand2} {
		foreach v1 $hand1 v2 $hand2 {
			if {$v1 == $v2} continue
			if {$v1 >  $v2} {return 1}
			if {$v1 <  $v2} {return -1}
		}
		return 0
	}
	proc handVals {hand} {
		variable ranks
		set suits {}; set points {};
		foreach card $hand {
			set suit [string index $card end]
			set point [string range $card 0 end-1]
			lappend suits $suit
			switch -- $point A {set point 1} J {set point 11} Q {set point 12} K {set point 13} default {}
			lappend points $point
		}
		set rank 0; set rankVals {}; set highVals {}
		set points [lsort -decreasing -integer $points]
		# check if is flush
		if {[llength [lsort -unique $suits]] == 1} {
			incr rank [dict get $ranks flush]
			set rankVals $points
		}
		# check if is straight
		if {[isStraight points]} {
			incr rank [dict get $ranks straight]
			set rankVals $points
		} elseif {$rank != [dict get $ranks flush]} {
			# find repeated points
			set prep [lindex $points 0]; set pc 1
			# the appending 0 here is to make sure the last point/pc being counted.
			foreach point [concat [lrange $points 1 end] 0] {
				if {$prep == $point} {
					incr pc
				} else {
					if {$pc == 4} {
						incr rank [dict get $ranks 4kind]
						set rankVals [linsert $rankVals 0 $prep]
					} elseif {$pc == 3} {
						incr rank [dict get $ranks 3kind]
						set rankVals [linsert $rankVals 0 $prep]
					} elseif {$pc == 2} {
						incr rank [dict get $ranks pair]
						lappend rankVals $prep
					} else {lappend highVals $prep}
					set prep $point; set pc 1
				}
			}
		}
		concat $rank $rankVals $highVals
	}
	proc isStraight {pointsName} {
		upvar $pointsName points
		set prep [lindex $points 0]
		foreach p [lrange $points 1 end] {
			if {$prep - $p != 1} {
				# special treament for A
				if {[lindex $points end] == 1} {
					set points [concat 14 [lrange $points 0 end-1]]
					tailcall isStraight points
				}
				return no
			}
			set prep $p
		}
		return yes
	}
}
namespace import ::Poker::*