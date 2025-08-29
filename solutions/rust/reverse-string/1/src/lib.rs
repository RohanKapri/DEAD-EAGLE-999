pub fn reverse(original_string: &str) -> String {
    let mut reversed = String::new();
    for ch in original_string.chars() {
        reversed.insert(0,ch);
    }
    reversed
}