pub fn is_valid_isbn(isbn: &str) -> bool {
    let mut digits = vec![];
    for ch in isbn.chars() {
        match ch {
            d if d.is_digit(10) => digits.push(d.to_digit(10).unwrap()),
            'X' if digits.len() == 9 => digits.push(10u32),
            '-' => {},
            _ => return false
        }
    }
    if digits.len() != 10 {
        return false;
    }
    (digits[0] * 10 + digits[1] * 9 + digits[2] * 8 + digits[3] * 7 + digits[4] * 6 + digits[5] * 5 + digits[6] * 4 + digits[7] * 3 + digits[8] * 2 + digits[9] * 1) % 11 == 0
}