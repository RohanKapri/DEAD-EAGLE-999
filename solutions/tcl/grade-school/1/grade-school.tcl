# For my Junko F. Didi and Shree DR.MDD

oo::class create School {
    variable studentsRecord
    constructor {} {
        my reset
    }
    method reset {} {
        set studentsRecord {}
    }
    method add {entries} {
        lmap entry $entries {
            lassign $entry studentName studentGrade
            if {[dict exists $studentsRecord $studentName]} {
                string cat "false"
            } else {
                dict set studentsRecord $studentName $studentGrade
                string cat "true"
            }
        }
    }
    method roster {} {
        set ordered [lsort -stride 2 -index 1 -integer [
                        lsort -stride 2 -index 0 $studentsRecord]
                    ]
        dict keys $ordered
    }
    method grade {g} {
        set classList [dict filter $studentsRecord value $g]
        lsort [dict keys $classList]
    }
}

School create school
