pub fn encrypt(input: &str) -> String {
    let mut input = input
        .chars()
        .filter(|ch| ch.is_ascii_alphanumeric())
        .map(|ch| ch.to_ascii_lowercase())
        .collect::<Vec<char>>();
    if input.is_empty() {
        return String::new();
    }
    let rlen = (input.len() as f32).sqrt().ceil() as usize;
    while input.len() % rlen != 0 {
        input.push(' ');
    }
    let rows = input.chunks(rlen).collect::<Vec<&[char]>>(); // rows
    let mut res = Vec::new();
    for slot in 0..rlen {
        rows.iter().for_each(|slice| res.push(slice[slot]));
        if slot + 1 < rlen {
            res.push(' ');
        }
    }
    res.iter().collect()
}