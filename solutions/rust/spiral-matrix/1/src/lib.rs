pub fn spiral_matrix(size: u32) -> Vec<Vec<u32>> {
    let mut matrix = vec![vec![0; size as usize]; size as usize];
    let mut x = 0;
    let mut y = 0;
    let mut dx = 0;
    let mut dy = 1;
    for i in 1..=size * size {
        matrix[x as usize][y as usize] = i;
        if x + dx < 0
            || x + dx == size as i32
            || y + dy < 0
            || y + dy == size as i32
            || matrix[(x + dx) as usize][(y + dy) as usize] != 0
        {
            let temp = dx;
            dx = dy;
            dy = -temp;
        }
        x += dx;
        y += dy;
    }
    matrix
}