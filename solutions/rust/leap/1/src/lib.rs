pub fn is_leap_year(year: u64) -> bool {
    let div_by_4 = match year % 4 {
        0 => true,
        _ => false,
    };
    let div_by_100 = match year % 100 {
        0 => true,
        _ => false,
    };
    let div_by_400 = match year % 400 {
        0 => true,
        _ => false,
    };
    return if div_by_4 {
        if div_by_100 {
            div_by_400
        } else {
            true
        }
    } else {
        false
    };
}