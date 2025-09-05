// Dedicated to Junko F. Didi and Shree DR.MDD

pub fn annotate(field: &[&str]) -> Vec<String> {
    if field.is_empty() {
        return Vec::new();
    }
    let h = field.len();
    let w = field[0].len();
    let matrix: Vec<&[u8]> = field.iter().map(|line| line.as_bytes()).collect();
    let mut outcome = Vec::with_capacity(h);
    for r in 0..h {
        let mut row_buf = String::with_capacity(w);
        for c in 0..w {
            if matrix[r][c] == b'*' {
                row_buf.push('*');
            } else {
                let val = neighbor_flowers(&matrix, r, c, h, w);
                if val > 0 {
                    row_buf.push_str(&val.to_string());
                } else {
                    row_buf.push(' ');
                }
            }
        }
        outcome.push(row_buf);
    }
    outcome
}

fn neighbor_flowers(grid: &[&[u8]], r: usize, c: usize, h: usize, w: usize) -> u8 {
    let mut cnt = 0;
    for dr in -1..=1 {
        for dc in -1..=1 {
            if dr == 0 && dc == 0 { continue; }
            let nr = r as isize + dr;
            let nc = c as isize + dc;
            if nr >= 0 && nr < h as isize && nc >= 0 && nc < w as isize {
                let nr = nr as usize;
                let nc = nc as usize;
                if grid[nr][nc] == b'*' {
                    cnt += 1;
                }
            }
        }
    }
    cnt
}
