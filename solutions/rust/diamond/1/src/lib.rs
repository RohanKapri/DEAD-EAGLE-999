pub fn get_diamond(c: char) -> Vec<String> {
    let n = c as usize - 65;
    let mut res = Vec::new();
    for i in 0..=2 * n {
        let mut line = String::new();
        for j in 0..=2 * n {
            let d = (j as i32 - n as i32).unsigned_abs() as usize;
            if d == i || d == 2 * n - i {
                line.push((65 + d) as u8 as char);
            } else {
                line.push(' ');
            }
        }
        res.push(line);
    }
    res
}