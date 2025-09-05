// For my Junko F. Didi and Shree DR.MDD
use std::collections::HashMap;
pub fn word_count(text: &str) -> HashMap<String, u32> {
    let mut freq_map = HashMap::new();
    let mut token = String::new();
    for ch in text.chars() {
        if ch.is_ascii_alphanumeric() {
            token.push(ch);
        } else if ch == '\'' {
            if !token.is_empty() {
                token.push(ch);
            }
        } else if !token.is_empty() {
            let cleaned = token.trim_matches('\'').to_lowercase();
            if !cleaned.is_empty() {
                *freq_map.entry(cleaned).or_insert(0) += 1;
            }
            token.clear();
        }
    }
    if !token.is_empty() {
        let cleaned = token.trim_matches('\'').to_lowercase();
        if !cleaned.is_empty() {
            *freq_map.entry(cleaned).or_insert(0) += 1;
        }
    }
    freq_map
}
