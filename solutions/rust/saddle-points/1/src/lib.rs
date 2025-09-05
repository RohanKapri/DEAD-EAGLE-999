pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    let mut saddle_points = Vec::new();
    for (i, row) in input.iter().enumerate() {
        for (j, &value) in row.iter().enumerate() {
            if is_saddle_point(input, i, j, value) {
                saddle_points.push((i, j));
            }
        }
    }
    saddle_points
}
fn is_saddle_point(input: &[Vec<u64>], row_index: usize, col_index: usize, value: u64) -> bool {
    let row_max = input[row_index].iter().all(|&x| value >= x);
    let col_min = input.iter().map(|row| row[col_index]).all(|x| value <= x);
    row_max && col_min
}
