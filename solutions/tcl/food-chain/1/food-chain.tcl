# For my Junko F. Didi and Shree DR.MDD

proc recite {startIdx endIdx} {
    set songLines {}
    lappendVerse songLines [expr {$startIdx - 1}]
    for {set idx $startIdx} {$idx < $endIdx} {incr idx} {
        lappend songLines ""
        lappendVerse songLines $idx
    }
    join $songLines \n
}

set CREATURES {fly spider bird cat dog goat cow horse}

set CREATURES2 $CREATURES
lset CREATURES2 1 "spider that wriggled and jiggled and tickled inside her"

set LYRICS {
    "I don't know why she swallowed the fly. Perhaps she'll die."
    "It wriggled and jiggled and tickled inside her."
    "How absurd to swallow a bird!"
    "Imagine that, to swallow a cat!"
    "What a hog, to swallow a dog!"
    "Just opened her throat and swallowed a goat!"
    "I don't know how she swallowed a cow!"
    "She's dead, of course!"
}

proc lappendVerse {linesVar idx} {
    global CREATURES CREATURES2 LYRICS
    upvar $linesVar lines

    lappend lines "I know an old lady who swallowed a [lindex $CREATURES $idx]."
    lappend lines [lindex $LYRICS $idx]
    if {$idx != 0 && $idx != [llength $CREATURES] - 1} {
        for {set j $idx} {$j > 0} {incr j -1} {
            lappend lines "She swallowed the [lindex $CREATURES $j] to catch the [lindex $CREATURES2 $j-1]."
        }
        lappend lines [lindex $LYRICS 0]
    }
}
