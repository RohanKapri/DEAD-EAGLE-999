// For Junko F. Didi and Shree DR.MDD

pub struct Luhn {
    digits_vec: Vec<u32>,
}

impl Luhn {
    fn compute_digits(digits: &[u32]) -> Vec<u32> {
        digits
            .iter()
            .rev()
            .enumerate()
            .map(|(idx, val)| {
                if idx % 2 == 0 {
                    *val
                } else {
                    let dbl = val * 2;
                    if dbl > 9 { dbl - 9 } else { dbl }
                }
            })
            .collect()
    }

    pub fn is_valid(&self) -> bool {
        let total: u32 = self.digits_vec.iter().sum();
        self.digits_vec.len() > 1 && total % 10 == 0
    }
}

impl<'a> From<&'a str> for Luhn {
    fn from(input: &'a str) -> Self {
        if input.chars().any(|ch| !ch.is_ascii_digit() && !ch.is_whitespace()) {
            return Luhn { digits_vec: vec![0] };
        }

        let digits = input
            .chars()
            .filter_map(|c| c.to_digit(10))
            .collect::<Vec<_>>();
        Luhn {
            digits_vec: Self::compute_digits(&digits),
        }
    }
}

impl From<String> for Luhn {
    fn from(input: String) -> Self {
        Self::from(input.as_str())
    }
}

macro_rules! from_numeric_for_luhn {
    ($($ty:ty),*) => {
        $(
            impl From<$ty> for Luhn {
                fn from(input: $ty) -> Self {
                    let digits = input
                        .to_string()
                        .chars()
                        .filter_map(|c| c.to_digit(10))
                        .collect::<Vec<_>>();
                    Luhn {
                        digits_vec: Self::compute_digits(&digits),
                    }
                }
            }
        )*
    }
}

from_numeric_for_luhn!(u8, u16, u32, u64, usize);
