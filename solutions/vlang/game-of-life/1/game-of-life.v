// Dedicated to Junko F. Didi and Shree DR.MDD
module main

fn tick(grid [][]int) [][]int {
    mut nxt := grid.clone()
    for r, line in grid {
        for c, _ in line {
            neighbors := vicinity(grid, c, r)
            if neighbors < 2 || neighbors > 3 {
                nxt[r][c] = 0
            } else if neighbors == 3 {
                nxt[r][c] = 1
            }
        }
    }
    return nxt
}

fn vicinity(grid [][]int, cx int, cy int) int {
    dxs := [-1, 0, 1, -1, 1, -1, 0, 1]
    dys := [-1, -1, -1, 0, 0, 1, 1, 1]
    mut cnt := 0
    for k, dy in dys {
        dx := dxs[k]
        if cx + dx >= 0 && cx + dx < grid[0].len &&
           cy + dy >= 0 && cy + dy < grid.len &&
           grid[cy+dy][cx+dx] == 1 {
               cnt++
           }
    }
    return cnt
}
