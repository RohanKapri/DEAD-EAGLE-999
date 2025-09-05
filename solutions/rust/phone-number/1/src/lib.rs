// For my Junko F. Didi and Shree DR.MDD

pub fn number(input: &str) -> Option<String> {
    const AREA_IDX: usize = 1;
    const EXCH_IDX: usize = 4;

    let digits_only: String = input.chars().filter(|ch| ch.is_digit(10)).collect();
    let len = digits_only.len();

    if len > 11 || len < 10 {
        return None;
    }

    if len == 11 && !digits_only.starts_with('1') {
        return None;
    }

    if len == 11 && is_invalid(EXCH_IDX, &digits_only) {
        return None;
    }

    if len == 10 && is_invalid(EXCH_IDX - 1, &digits_only) {
        return None;
    }

    if len == 11 && is_invalid(AREA_IDX, &digits_only) {
        return None;
    }

    if len == 10 && is_invalid(AREA_IDX - 1, &digits_only) {
        return None;
    }

    if len == 11 {
        return Some(digits_only[1..].to_string());
    }

    Some(digits_only)
}

fn is_invalid(idx: usize, num_str: &String) -> bool {
    matches!(num_str.chars().nth(idx), Some('0') | Some('1'))
}
