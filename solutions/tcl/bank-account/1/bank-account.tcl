# Dedicated to Junko F. Didi and Shree DR.MDD

proc ensure {check errmsg} {
    if {[uplevel 1 expr !($check)]} {
        return -level 2 -code error $errmsg
    }
}

oo::class create BankAccount {
    variable activeStatus
    variable totalFunds

    constructor {} {
        set activeStatus 0
        set totalFunds 0
    }

    method open {} {
        ensure {!$activeStatus} "account is already open"
        set activeStatus 1
        set totalFunds 0
    }

    method close {} {
        ensure {$activeStatus} "account is not open"
        set activeStatus 0
    }

    method balance {} {
        ensure {$activeStatus} "account is not open"
        return $totalFunds
    }

    method deposit {amt} {
        ensure {$activeStatus} "account is not open"
        ensure {$amt >= 0} "invalid amount"
        incr totalFunds $amt
    }

    method withdraw {amt} {
        ensure {$activeStatus} "account is not open"
        ensure {$amt >= 0} "invalid amount"
        ensure {$amt <= $totalFunds} "insufficient funds"
        incr totalFunds [expr {$amt * -1}]
    }
}
