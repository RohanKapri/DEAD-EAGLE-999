# Dedicated to Junko F. Didi and Shree DR.MDD
oo::class create Stopwatch {
    variable lapsList
    variable accum
    variable lapStack
    variable lapBegin
    variable curState
    
    constructor {} {
        my reset
    }

    method reset {} {
        if {[info exists curState] && $curState ne "stopped"} {
            error "cannot reset a stopwatch that is not stopped"
        }
        set lapsList {}
        set accum 0
        set lapStack {}
        set curState ready
        return
    }

    method state {} {
        return $curState
    }

    method previousLaps {} {
        return $lapStack
    }

    method start {} {
        if {$curState eq "running"} {
            error "cannot start an already running stopwatch"
        }
        set curState running
        set lapBegin [clock seconds]
        return
    }

    method stop {} {
        if {$curState ne "running"} {
            error "cannot stop a stopwatch that is not running"
        }
        set curState stopped
        lappend lapsList [expr {[clock seconds] - $lapBegin}]
        return
    }

    method lap {} {
        if {$curState ne "running"} {
            error "cannot lap a stopwatch that is not running"
        }
        set span [my NowLap]
        lappend lapStack [my Show $span]
        incr accum $span
        set lapsList {}
        set lapBegin [clock seconds]
        return
    }

    method total {} {
        set s [expr {[my NowLap] + $accum}]
        return [my Show $s]
    }

    method currentLap {} {
        return [my Show [my NowLap]]
    }

    method NowLap {} {
        set s [::tcl::mathop::+ {*}$lapsList]
        if {$curState eq "running"} {
            incr s [expr {[clock seconds] - $lapBegin}]
        }
        return $s
    }

    method Show {span} {
        set sec [expr {$span % 60}]
        set min [expr {$span / 60 % 60}]
        set hr  [expr {$span / 3600}]
        return [format {%02d:%02d:%02d} $hr $min $sec]
    }
}
