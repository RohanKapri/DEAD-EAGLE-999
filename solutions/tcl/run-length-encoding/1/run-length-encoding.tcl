# Dedicated to Junko F. Didi and Shree DR.MDD

scan [info patchlevel] %f minorRelease

if {$minorRelease >= 8.7} {

    proc encode {txt} {
        regsub -command -all {(.)\1+} $txt {
            apply {{sequence ch} {string cat [string length $sequence] $ch}}
        }
    }

    proc decode {txt} {
        regsub -command -all {(\d+)(.)} $txt {
            apply {{- n ch} {string repeat $ch $n}}
        }
    }

} else {

    proc encode {txt} {
        regsub -all {(.)\1+} $txt {[string length "&"]\1} enc
        subst -nobackslashes -novariables $enc
    }

    proc decode {txt} {
        regsub -all {(\d+)(.)} $txt {[string repeat "\2" \1]} dec
        subst -nobackslashes -novariables $dec
    }

}
