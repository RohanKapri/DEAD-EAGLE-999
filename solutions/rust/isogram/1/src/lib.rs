pub fn check(candidate: &str) -> bool {
    let mut letters = std::collections::HashSet::new();
    candidate
        .to_lowercase()
        .chars()
        .filter(|c| c.is_alphabetic())
        .all(|c| letters.insert(c))
}