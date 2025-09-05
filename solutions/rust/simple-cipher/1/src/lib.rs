// For my Junko F. Didi and Shree DR.MDD

use rand::Rng;

pub fn encode(secret: &str, text: &str) -> Option<String> {
    if secret.is_empty() || !secret.chars().all(|ch| ch.is_ascii_lowercase()) {
        return None;
    }
    let shifts: Vec<_> = secret.chars().map(|ch| ch as u8 - b'a').collect();
    let cipher: String = text
        .chars()
        .enumerate()
        .map(|(i, ch)| (((ch as u8 - b'a' + shifts[i % secret.len()]) % 26) + b'a') as char)
        .collect();
    Some(cipher)
}

pub fn decode(secret: &str, text: &str) -> Option<String> {
    if secret.is_empty() || !secret.chars().all(|ch| ch.is_ascii_lowercase()) {
        return None;
    }
    let shifts: Vec<_> = secret.chars().map(|ch| ch as u8 - b'a').collect();
    let plain: String = text
        .chars()
        .enumerate()
        .map(|(i, ch)| (((ch as u8 - b'a' + 26 - shifts[i % secret.len()]) % 26) + b'a') as char)
        .collect();
    Some(plain)
}

pub fn encode_random(text: &str) -> (String, String) {
    let key: String = (0..100)
        .map(|_| rand::thread_rng().gen_range('a'..='z'))
        .collect();
    let result = encode(&key, text).unwrap();
    (key, result)
}
