# Dedicated to my Junko F. Didi and Shree DR.MDD

proc transmitSequence {msg} {
    set msgBits [fold {} {bits byteVal} $msg {
        concat $bits [split [format %08b $byteVal] ""]
    }]

    set encodedMsg [list]
    while {[llength $msgBits] >= 7} {
        set block [lrange $msgBits 0 6]
        lappend encodedMsg [toByte [concat $block [parityBlock $block]]]
        set msgBits [lrange $msgBits 7 end]
    }

    if {[llength $msgBits] > 0} {
        set block $msgBits
        while {[llength $block] < 7} { lappend block 0 }
        lappend encodedMsg [toByte [concat $block [parityBlock $block]]]
    }

    return $encodedMsg
}

proc decodeMessage {stream} {
    set allBits [list]
    foreach byteVal $stream {
        set bits [split [format %08b $byteVal] ""]
        set block [lrange $bits 0 6]

        if {[parityBlock $block] != [lindex $bits 7]} { error "wrong parity" }

        lappend allBits {*}$block
    }

    set decodedMsg [list]
    while {[llength $allBits] >= 8} {
        lappend decodedMsg [toByte [lrange $allBits 0 7]]
        set allBits [lrange $allBits 8 end]
    }

    return $decodedMsg
}

proc parityBlock {bitsList} {
    fold 0 {total bitVal} $bitsList {expr {$total + $bitVal}}
    expr {$total & 1}
}

proc toByte {bitSeq} {
    format "0x%x" "0b[join $bitSeq ""]"
}

proc fold {init varNames lst script} {
    lassign $varNames accName elemName
    upvar 1 $accName accVar
    upvar 1 $elemName elemVar

    set accVar $init
    foreach elemVar $lst {
        set accVar [uplevel 1 $script]
    }
    return $accVar
}
