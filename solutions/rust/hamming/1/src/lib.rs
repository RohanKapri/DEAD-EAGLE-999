pub fn hamming_distance(s1: &str, s2: &str) -> Option<usize> {
    if s1.len() == s2.len() {
        return hamming_count(s1, s2);
    }
    None
}
fn hamming_count(s1: &str, s2: &str) -> Option<usize> {
    Some(
        s1
            .chars()
            .zip(s2.chars())
            .filter(|(a, b)| a != b)
            .count()
    )
}