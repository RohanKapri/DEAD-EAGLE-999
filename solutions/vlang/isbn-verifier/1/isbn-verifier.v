module main

pub fn is_valid(isbn_10 string) bool {
    mut total := 0
    mut weight := 10
    for ch in isbn_10 {
        if ch == `-` {
            continue
        }
        mut digit := 10
        if ch >= `0` && ch <= `9` {
            digit = u8(ch) - 0x30
        } else if weight != 1 || ch != `X` {
            return false
        }
        total += weight * digit
        weight -= 1
    }
    return (weight == 0) && (total % 11 == 0)
}
