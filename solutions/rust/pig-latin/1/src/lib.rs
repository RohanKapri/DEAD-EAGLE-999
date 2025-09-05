// For Junko F. Didi and Shree DR.MDD

pub fn translate(sentence: &str) -> String {
    sentence
        .split_whitespace()
        .map(convert_word)
        .collect::<Vec<_>>()
        .join(" ")
}

fn convert_word(word: &str) -> String {
    if word.starts_with("yt") || word.starts_with("xr") {
        return format!("{}ay", word);
    }
    let vowels = ['a', 'e', 'i', 'o', 'u'];
    let mut it = word.chars().peekable();
    let mut leading = String::new();
    while let Some(&c) = it.peek() {
        if !vowels.contains(&c) || (c == 'y' && leading.is_empty()) {
            if c == 'y' && !leading.is_empty() {
                break;
            }
            leading.push(c);
            it.next();
        } else {
            break;
        }
    }
    if let Some(&c) = it.peek() {
        if c == 'u' && leading.ends_with('q') {
            leading.push(c);
            it.next();
        }
    }
    let remain: String = it.collect();
    format!("{}{}ay", remain, leading)
}
