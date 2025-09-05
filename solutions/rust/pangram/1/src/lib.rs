const LOWERCASE_A_USIZE: usize = 'a' as usize;
const UPPERCASE_A_USIZE: usize = 'A' as usize;
pub fn is_pangram(sentence: &str) -> bool {
    let mut buf: [bool; 26] = [false; 26];
    for letter in sentence.chars() {
        if letter >= 'a' && letter <= 'z' {
            buf[(letter as usize) - LOWERCASE_A_USIZE] = true;
            continue;
        }
        if letter >= 'A' && letter <= 'Z' {
            buf[(letter as usize) - UPPERCASE_A_USIZE] = true;
        }
    }
    for c in buf {
        if !c {
            return false;
        }
    }
    true
}