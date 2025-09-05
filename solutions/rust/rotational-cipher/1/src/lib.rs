pub fn rotate(input: &str, key: u8) -> String {
    input
        .chars()
        .map(|c| {
            if c.is_alphabetic() {
                let base = if c.is_lowercase() { b'a' } else { b'A' };
                ((c as u8 - base + key) % 26 + base) as char
            } else {
                c
            }
        })
        .collect()
}