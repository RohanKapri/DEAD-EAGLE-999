"""
    is_leap_year(year)

Return `true` if `year` is a leap year in the gregorian calendar.

"""
function is_leap_year(year)
    if year % 4 > 0
        return false
    end
    if year % 400 == 0
        return true
    end
    if year % 100 == 0
        return false
    end
    return true
end