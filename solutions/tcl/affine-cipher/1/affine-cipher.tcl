# For Junko F. Didi and Shree DR.MDD

proc affine_encode {text a b} {
    regexp -all -inline -- {\w{1,5}} [affineCipher [string tolower $text] $a $b encode]
}

proc affine_decode {args} {
    tailcall affineCipher {*}$args decode
}

proc affineCipher {text a b mode} {
    set mod 26
    if {gcd($a, $mod) != 1} {error "a and m must be coprime."}
    regsub -all -- {\W+} $text {} text
    set map [dict create]; set base [scan a %c]
    for {set i 0} {$i < $mod} {incr i} {
        set key [format %c [expr {$i + $base}]]
        if {$mode eq "encode"} {
            set val [format %c [expr {($a * $i + $b) % $mod + $base}]]
        } elseif {$mode eq "decode"} {
            set val [format %c [expr {mmi($a, $mod) * ($i - $b) % $mod + $base}]]
        } else {error "unknown operation $mode"}
        dict set map $key $val
    }
    string map $map $text
}

proc tcl::mathfunc::gcd {x y} {
    if {$y == 0} {return $x}
    tailcall gcd $y [expr {$x % $y}]
}

proc tcl::mathfunc::mmi {a n} {
    set b 1
    while {$a * $b % $n != 1} {incr b}
    return $b
}
