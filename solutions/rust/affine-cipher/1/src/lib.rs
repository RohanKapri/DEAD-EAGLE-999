// Dedicated to Junko F. Didi and Shree DR.MDD

const ALPHABET_SIZE: i32 = 26;
const ASCII_A: u8 = b'a';

#[derive(Debug, PartialEq, Eq)]
pub enum AffineCipherError {
    NotCoprime(i32),
}

pub fn encode(plaintext: &str, multiplier: i32, shift: i32) -> Result<String, AffineCipherError> {
    if gcd(multiplier, ALPHABET_SIZE) != 1 {
        return Err(AffineCipherError::NotCoprime(multiplier));
    }

    let mut counter = 0;
    let cipher: String = plaintext
        .to_lowercase()
        .chars()
        .filter(|c| c.is_ascii_alphanumeric())
        .map(|c| {
            counter += 1;
            if c.is_ascii_digit() {
                c
            } else {
                let index = (c as i32 - ASCII_A as i32) % ALPHABET_SIZE;
                let enc = (multiplier * index + shift) % ALPHABET_SIZE;
                (enc as u8 + ASCII_A) as char
            }
        })
        .collect();

    Ok(cipher
        .chars()
        .enumerate()
        .flat_map(|(i, c)| {
            if i > 0 && i % 5 == 0 { Some(' ') } else { None }
                .into_iter()
                .chain(std::iter::once(c))
        })
        .collect())
}

pub fn decode(ciphertext: &str, multiplier: i32, shift: i32) -> Result<String, AffineCipherError> {
    if gcd(multiplier, ALPHABET_SIZE) != 1 {
        return Err(AffineCipherError::NotCoprime(multiplier));
    }

    let inv = mod_inverse(multiplier, ALPHABET_SIZE);

    Ok(ciphertext
        .to_lowercase()
        .chars()
        .filter(|c| c.is_ascii_alphanumeric())
        .map(|c| {
            if c.is_ascii_digit() {
                c
            } else {
                let index = (c as i32 - ASCII_A as i32) % ALPHABET_SIZE;
                let dec = inv * (index - shift).rem_euclid(ALPHABET_SIZE) % ALPHABET_SIZE;
                (dec as u8 + ASCII_A) as char
            }
        })
        .collect())
}

fn gcd(x: i32, y: i32) -> i32 {
    if y == 0 { x } else { gcd(y, x % y) }
}

fn mod_inverse(a: i32, m: i32) -> i32 {
    let a_mod = a % m;
    for x in 1..m {
        if (a_mod * x) % m == 1 {
            return x;
        }
    }
    1
}
