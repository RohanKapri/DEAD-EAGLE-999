use std::collections::HashSet;
use unicode_segmentation::UnicodeSegmentation;
fn sorted_chars(word: &str) -> Vec<char> {
    let mut word = word.chars().collect::<Vec<char>>();
    word.sort();
    word
}
pub fn anagrams_for<'a>(word: &'a str, possible_anagrams: &'a [&'a str]) -> HashSet<&'a str> {
    let word = word.to_lowercase().graphemes(true).collect::<String>();
    let sorted_word = sorted_chars(&word);
    possible_anagrams.iter()
        .filter(|candidate| {
            let candidate_lower = candidate.to_lowercase().graphemes(true).collect::<String>();
            word != candidate_lower && sorted_word == sorted_chars(&candidate_lower)
        })
        .copied()
        .collect()
}
