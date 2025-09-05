pub fn series(digits: &str, len: usize) -> Vec<String> {
    match digits.len() {
        lx if len == lx => vec![digits.to_string()],
        lx if len > lx => vec![],
        _ if len == 0 => vec!["".to_string(); digits.len() + 1],
        _ => {
            let characters: Vec<char> = digits.chars().collect();
            characters
                .windows(len)
                .map(|c| c.iter().collect())
                .collect()
        }
    }
}