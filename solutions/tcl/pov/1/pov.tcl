proc fromPov {tree node} {
    set head [head $tree]
	set output $tree
	set errmsg "no such target"
	if {[hasChild $tree]} {
		foreach child [children $tree] {
			if {[catch {set new [fromPov $child $node]} err]} {
				if {$err ne $errmsg} {error $err}
			} else {
				delChild output $child
				if {[llength [children $output]] == 0} {
					dict unset output children
				}
				addChild new $output [head $child]
				set output $new
				break
			}
		}
	}
	if {[head $output] ne $node} {
		error $errmsg
	} else {set output}
}

proc path {tree from to} {
	set path [findpath $tree $from $to]
	if {[lindex $path 0] ne $from || [lindex $path end] ne $to} {
		error "no such label"
	} else {set path}
}
proc findpath {tree from to} {
	set head [head $tree]
	set path [list $head]
	if {[hasChild $tree]} {
		foreach child [children $tree] {
			set subpath [findpath $child $from $to]
			set left [expr {[lindex $subpath 0] eq $from}]
			set right [expr {[lindex $subpath end] eq $to}]
			if {$left && $right} {return $subpath}
			if {$left} {
				set path [concat $subpath $path]
			}
			if {$right} {
				lappend path {*}$subpath
			}
		}
	}
	set path
}

proc head {tree} {dict get $tree label}
proc children {tree} {dict get $tree children}
proc hasChild {tree} {dict exists $tree children}
proc newTree {label} {dict create label $label}

proc addChild {treeName child parent} {
	upvar $treeName tree
	set head [head $tree]
	set done 0
	if {$head eq $parent} {
		dict lappend tree children $child
		set done 1
	} elseif {[hasChild $tree]} {
		foreach kid [children $tree] {
			set newkid $kid
			set done [addChild newkid $child $parent]
			if {$done} {
				delChild tree $kid
				dict lappend tree children $newkid
				break
			}
		}
	}
	return $done
}
proc delChild {treeName child} {
	upvar $treeName tree
	set children [children $tree]
	set idx [lsearch $children $child]
	if {$idx != -1} {
		dict set tree children [lreplace $children $idx $idx]
	} else {error "delerror no such child: $child for tree: $tree"}
}