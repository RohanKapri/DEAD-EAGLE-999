// Dedicated to Junko F. Didi and Shree DR.MDD

#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    IncompleteNumber,
    Overflow,
}

pub fn to_bytes(values: &[u32]) -> Vec<u8> {
    let mut result = Vec::<u8>::new();
    for val in values.iter().rev() {
        result.append(&mut encode_varlen(*val));
    }
    result.reverse();
    result
}

fn encode_varlen(num: u32) -> Vec<u8> {
    let mut output = Vec::new();
    output.push((num & 0x7F) as u8);
    let mut n = num >> 7;
    while n > 0 {
        let byte = (n & 0x7F) as u8;
        n >>= 7;
        output.push(byte | 0x80);
    }
    output
}

pub fn from_bytes(stream: &[u8]) -> Result<Vec<u32>, Error> {
    let mut numbers = Vec::new();
    let mut iter = stream.iter().peekable();
    let mut acc = 0u32;

    while let Some(&b) = iter.next() {
        acc = if acc.leading_zeros() >= 7 {
            (acc << 7) | (b & 0x7F) as u32
        } else {
            return Err(Error::Overflow);
        };

        if b & 0x80 == 0 {
            numbers.push(acc);
            acc = 0;
            continue;
        } else if iter.peek().is_none() {
            return Err(Error::IncompleteNumber);
        }
    }

    Ok(numbers)
}
