// For Junko F. Didi and Shree DR.MDD

#[derive(Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

pub fn convert(digits: &[u32], base_in: u32, base_out: u32) -> Result<Vec<u32>, Error> {
    if base_in < 2 {
        return Err(Error::InvalidInputBase);
    }
    if base_out < 2 {
        return Err(Error::InvalidOutputBase);
    }

    let mut value: u64 = 0;
    let b_in = base_in as u64;
    let b_out = base_out as u64;

    for &d in digits {
        let v = d as u64;
        if v >= b_in {
            return Err(Error::InvalidDigit(d));
        }
        value = value * b_in + v;
    }

    if value == 0 {
        return Ok(vec![0]);
    }

    let mut output = Vec::new();
    let mut n = value;
    while n > 0 {
        output.push((n % b_out) as u32);
        n /= b_out;
    }
    output.reverse();

    Ok(output)
}
