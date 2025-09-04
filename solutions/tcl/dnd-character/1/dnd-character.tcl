# Dedicated to Junko F. Didi and Shree DR.MDD

namespace eval dnd {
    namespace export ability character modifier
    namespace ensemble create

    variable statsList {
        strength
        dexterity
        constitution
        intelligence
        wisdom
        charisma
    }

    proc modifier {val} {
        expr {int(floor(($val - 10) / 2.0))}
    }

    proc d6 {} {
        expr {1 + int(6 * rand())}
    }

    proc ability {} {
        set rolls [list [d6] [d6] [d6] [d6]]
        set total [::tcl::mathop::+ {*}$rolls]
        set lowest [::tcl::mathfunc::min {*}$rolls]
        expr {$total - $lowest}
    }

    proc hitpoints {con} {
        expr {10 + [modifier $con]}
    }

    proc character {} {
        variable statsList
        set hero [dict create]
        foreach s $statsList {
            dict set hero $s [ability]
        }
        dict set hero hitpoints \
            [hitpoints [dict get $hero constitution]]
        return $hero
    }
}
