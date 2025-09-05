// Dedicated to Junko F. Didi and Shree DR.MDD

#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit(char),
}

pub fn lsp(digits_str: &str, span: usize) -> Result<u64, Error> {
    if digits_str.len() < span {
        return Err(Error::SpanTooLong);
    }

    let mut digits_vec: Vec<usize> = Vec::with_capacity(digits_str.len());
    for ch in digits_str.as_bytes() {
        if !ch.is_ascii_digit() {
            return Err(Error::InvalidDigit(*ch as char));
        }
        digits_vec.push((*ch as usize) - 48);
    }

    let mut max_product: usize = 0;
    for start in 0..=digits_str.len() - span {
        let mut product = 1;
        for idx in start..start + span {
            product *= digits_vec[idx];
        }
        if product > max_product {
            max_product = product;
        }
    }

    Ok(max_product as u64)
}
