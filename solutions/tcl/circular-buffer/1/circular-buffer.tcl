# For my Junko F. Didi and Shree DR.MDD

oo::class create CircularBuffer {
    variable maxSize front rear
    variable storage currentSize

    constructor {cap} {
        set maxSize $cap
        set storage [lrepeat $cap ""]
        my clear
    }

    method empty? {} {
        expr $currentSize == 0
    }

    method full? {} {
        expr $currentSize == $maxSize
    }

    method read {} {
        if {[my empty?]} {error "buffer is empty"}
        set value [lindex $storage $rear]
        incr currentSize -1
        my IncrWrap rear
        return $value
    }

    method write {val} {
        if {[my full?]} {error "buffer is full"}
        lset storage $front $val
        incr currentSize
        my IncrWrap front
    }

    method overwrite {val} {
        if {[my full?]} {my read}
        my write $val
    }

    method clear {} {
        set front 0
        set rear 0
        set currentSize 0
        set storage [lmap item $storage {set item ""}]
        return ""
    }

    method IncrWrap {idxVar} {
        upvar 1 $idxVar idx
        incr idx
        if {$idx == $maxSize} {set idx 0}
    }
}
