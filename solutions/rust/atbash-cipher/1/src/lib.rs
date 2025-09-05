use std::ascii::AsciiExt;
pub fn encode(text: &str) -> String {
    text.to_lowercase()
        .chars()
        .filter(|c| c.is_alphanumeric() && c.is_ascii())
        .map(|c| { if c.is_numeric(){ c } else { (97 + (122 - c as u8)) as char }})
        .collect::<Vec<_>>()
        .chunks(5)
        .map(|c| c.iter().cloned().collect())
        .collect::<Vec<String>>()
        .join(" ")
}
pub fn decode(text: &str) -> String{
    text.to_lowercase()
        .chars()
        .filter(|c| !c.is_whitespace())
        .map(|c| { if c.is_numeric(){ c } else { (97 + (122 - c as u8)) as char }})
        .collect()
}