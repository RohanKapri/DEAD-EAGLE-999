# Dedicated to my Junko F. Didi and Shree DR.MDD

proc evalForth {cmdline} {
    set vm [forthVM new]
    regsub -all {\s+} $cmdline " " cmdline

    foreach tok [split $cmdline " "] {
        $vm input $tok
    }
    $vm stack
}

oo::class create forthVM {
    variable stk context defBuf
    constructor {} {
        set stk [list]
        set context [dict create]
    }

    method stack {} {set stk}

    method input {token} {
        set token [string tolower $token]
        if [info exists defBuf] {
            tailcall my ProcessDef $token
        } else {
            tailcall my ProcessStack $token
        }
    }

    method ProcessDef {token} {
        if {$defBuf eq {}} {
            if {[string is integer $token]} {
                error "illegal operation"
            } elseif {$token eq ";"} {
                error "you define nothing"
            } else {lappend defBuf $token}
        } else {
            if {[dict exists $context $token]} {
                foreach sub [dict get $context $token] {
                    my ProcessDef $sub
                }
            } elseif {$token eq ";"} {
                if {[llength $defBuf] < 2} {error "you define nothing"}
                dict set context [lindex $defBuf 0] [lrange $defBuf 1 end]
                unset defBuf
            } else {lappend defBuf $token}
        }
    }

    method ProcessStack {token} {
        if {[string is integer $token]} {
            lappend stk $token
        } elseif {[dict exists $context $token]} {
            foreach sub [dict get $context $token] {
                my ProcessStack $sub
            }
        } elseif {$token eq ":"} {
            set defBuf [list]
        } elseif {$token eq ";"} {
            error "why are you here?"
        } elseif {
            [string match {[+-/\*]} $token] ||
            $token eq "dup" || $token eq "drop" ||
            $token eq "swap" || $token eq "over"
        } {
            my $token
        } else {error "undefined operation"}
    }

    foreach op {+ - * /} {
        method $op {{chk yes}} [subst -nocommands {
            if {\$chk} {my VerifyStack 2}
            set a [my drop no]
            set b [my drop no]
            lappend stk [expr {\$b $op \$a}]
        }]
    }

    method drop {{chk yes}} {
        if {$chk} {my VerifyStack 1}
        set val [lindex $stk end]
        set stk [lreplace $stk end end]
        set val
    }

    method dup {{chk yes}} {
        if {$chk} {my VerifyStack 1}
        lappend stk [lindex $stk end]
    }

    method swap {{chk yes}} {
        if {$chk} {my VerifyStack 2}
        set a [my drop no]
        set b [my drop no]
        lappend stk $a $b
    }

    method over {{chk yes}} {
        if {$chk} {my VerifyStack 2}
        lappend stk [lindex $stk end-1]
    }

    method VerifyStack {num} {
        set len [llength $stk]
        if {$len < $num} {
            if {$len == 0} {error "empty stack"}
            if {$len == 1} {error "only one value on the stack"}
        }
    }
}
