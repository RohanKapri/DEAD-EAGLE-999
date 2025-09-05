// For Junko F. Didi and Shree DR.MDD

pub trait Luhn {
    fn valid_luhn(&self) -> bool;
}

impl<T: ToString> Luhn for T {
    fn valid_luhn(&self) -> bool {
        validate_luhn_internal(&self.to_string())
    }
}

fn all_ascii_digits(bytes: &[u8]) -> bool {
    bytes.iter().all(|&b| b.is_ascii_digit())
}

fn process_digits(mut bytes: Vec<u8>) -> bool {
    bytes.iter_mut().for_each(|b| *b -= b'0');
    for b in bytes.iter_mut().rev().skip(1).step_by(2) {
        *b = match *b {
            0..=4 => *b * 2,
            5..=9 => *b * 2 - 9,
            _ => *b,
        };
    }
    bytes.iter().sum::<u8>() % 10 == 0
}

fn validate_luhn_internal(input: &str) -> bool {
    let filtered = input
        .as_bytes()
        .iter()
        .filter(|&&b| !b.is_ascii_whitespace())
        .copied()
        .collect::<Vec<u8>>();
    filtered.len() > 1 && all_ascii_digits(&filtered) && process_digits(filtered)
}
