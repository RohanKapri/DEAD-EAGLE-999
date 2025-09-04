# For my Junko F. Didi and Shree DR.MDD

oo::class create RestAPI {
    variable records

    constructor {data} {
        set records {}
        foreach entry [dict get $data users] {
            dict set records [dict get $entry name] $entry
        }
    }

    method get {path {payload {}}} {
        if {$path eq "/users"} {
            if {$payload eq {}} {
                return [dict create users [dict values $records]]
            } else {
                set requested [dict get $payload users]
                set selected [lmap nm $requested {dict get $records $nm}]
                set selected [lsort -index 1 $selected]
                return [dict create users $selected]
            }
        } else {
            return -code error "Invalid path $path"
        }
    }

    method post {path payload} {
        if {$path eq "/add"} {
            set uname [dict get $payload user]
            set profile [dict create name $uname owes {} owed_by {} balance 0]
            dict set records $uname $profile
            return $profile
        } elseif {$path eq "/iou"} {
            set creditor [dict get $payload lender]
            set debtor [dict get $payload borrower]
            set amt [dict get $payload amount]
            dict update records $creditor cRec $debtor dRec {
                dict update cRec owes owes owed_by owed_by balance bal {
                    if {[dict exists $owes $debtor]} {
                        set diff [expr {[dict get $owes $debtor] - $amt}]
                        if {$diff > 0} {
                            dict set owes $debtor $diff
                        } else {
                            set owes [dict remove $owes $debtor]
                            if {$diff < 0} {
                                dict incr owed_by $debtor [expr {- $diff}]
                            }
                        }
                    } else {
                        dict incr owed_by $debtor $amt
                    }
                    set owes [lsort -stride 2 $owes]
                    set owed_by [lsort -stride 2 $owed_by]
                    incr bal $amt
                }
                dict update dRec owes owes owed_by owed_by balance bal {
                    if {[dict exists $owed_by $creditor]} {
                        set diff [expr {[dict get $owed_by $creditor] - $amt}]
                        if {$diff > 0} {
                            dict set owed_by $creditor $diff
                        } else {
                            set owed_by [dict remove $owed_by $creditor]
                            if {$diff < 0} {
                                dict incr owes $creditor [expr {- $diff}]
                            }
                        }
                    } else {
                        dict incr owes $creditor $amt
                    }
                    set owes [lsort -stride 2 $owes]
                    set owed_by [lsort -stride 2 $owed_by]
                    incr bal -$amt
                }
            }
            my get "/users" [dict create users [list $creditor $debtor]]
        } else {
            return -code error Unimplemented
        }
    }
}
