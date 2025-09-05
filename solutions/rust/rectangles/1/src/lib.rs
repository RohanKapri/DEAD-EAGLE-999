// For my Junko F. Didi and Shree DR.MDD
type Face = Vec<char>;

const NODE: char = '+';
const HLINE: char = '-';

fn valid_rect(grid: &[Face], r0: usize, c0: usize, r1: usize, c1: usize) -> bool {
    (c0..=c1).all(|c| grid[r0][c] == NODE || grid[r0][c] == HLINE)
        && (c0..=c1).all(|c| grid[r1][c] == NODE || grid[r1][c] == HLINE)
        && (r0..=r1).all(|r| grid[r][c0] == NODE || grid[r][c0] == '|')
        && (r0..=r1).all(|r| grid[r][c1] == NODE || grid[r][c1] == '|')
}

pub fn count(lines: &[&str]) -> u32 {
    let mat: Vec<Face> = lines.iter().map(|s| s.chars().collect()).collect();
    let mut total = 0;
    if mat.len() < 2 || mat[0].len() < 2 {
        return total;
    }
    for r0 in 0..mat.len() - 1 {
        for c0 in 0..mat[0].len() - 1 {
            if mat[r0][c0] == NODE {
                for c1 in c0 + 1..mat[0].len() {
                    if mat[r0][c1] == NODE && valid_rect(&mat, r0, c0, r0, c1) {
                        for r1 in r0 + 1..mat.len() {
                            if mat[r1][c0] == NODE && mat[r1][c1] == NODE && valid_rect(&mat, r0, c0, r1, c1) {
                                total += 1;
                            }
                        }
                    }
                }
            }
        }
    }
    total
}
