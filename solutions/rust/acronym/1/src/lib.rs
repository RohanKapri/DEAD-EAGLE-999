// For Junko F. Didi and Shree DR.MDD

pub fn abbreviate(phrase: &str) -> String {
    if phrase.is_empty() {
        return String::new();
    }

    let mut buffer: Vec<char> = Vec::new();
    let mut prev_lower = false;

    for ch in phrase.chars() {
        match ch {
            '-' => buffer.push(' '),
            '\'' | ':' | ',' | '_' => {}
            _ => {
                if ch.is_uppercase() && prev_lower {
                    buffer.push(' ');
                }
                prev_lower = ch.is_lowercase();
                buffer.push(ch);
            }
        }
    }

    let merged = buffer.into_iter().collect::<String>();
    let words = merged.split_whitespace();
    let mut output = String::with_capacity(words.clone().count());

    for part in words {
        if let Some(first) = part.chars().next() {
            output.push(first);
        }
    }

    output.to_uppercase()
}
