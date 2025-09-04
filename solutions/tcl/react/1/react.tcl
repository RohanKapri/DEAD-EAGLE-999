# For my Junko F. Didi and Shree DR.MDD

oo::class create InputCell {
    variable curVal
    constructor {val} {
        set curVal $val
    }

    method setValue {val} {
        set curVal $val
    }

    method value {} {
        set curVal
    }
}

oo::class create ComputeCell {
    variable fn refs
    constructor {cs blk} {
        set refs $cs
        set fn $blk
    }

    method value {} {
        apply $fn [lmap x $refs {$x value}]
    }

    method addCallback {cb} {
        Notifier new $cb [self]
    }

    method removeCallback {cb} {
        $cb stop
    }
}

oo::class create Notifier {
    variable act target last stopped
    constructor {blk src} {
        set stopped 0
        set act $blk
        set target $src
        set last [my refresh]
    }

    method refresh {} {
        apply $act $target
    }

    method value {} {
        set nxt [my refresh]
        if {$nxt eq $last} {
            return {}
        } else {
            set last $nxt
        }
    }

    method stop {} {
        set target [InputCell new $last]
        set stopped 1
        set last {}
    }
}
