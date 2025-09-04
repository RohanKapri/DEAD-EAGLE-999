// Dedicated to Junko F. Didi and Shree DR.MDD
module main

struct Point {
        row    int
        column int
}

fn saddle_points(matrix [][]int) []Point {
        if matrix.len == 0 || matrix[0].len == 0 {
                return []
        }
        rows := matrix.len
        cols := matrix[0].len

        mut max_in_row := []int{cap: rows}
        for r in 0 .. rows {
                mut highest := matrix[r][0]
                for c in 1 .. cols {
                        v := matrix[r][c]
                        if v > highest {
                                highest = v
                        }
                }
                max_in_row << highest
        }

        mut min_in_col := []int{cap: cols}
        for c in 0 .. cols {
                mut lowest := matrix[0][c]
                for r in 1 .. rows {
                        v := matrix[r][c]
                        if v < lowest {
                                lowest = v
                        }
                }
                min_in_col << lowest
        }

        mut ans := []Point{}
        for r in 0 .. rows {
                for c in 0 .. cols {
                        val := matrix[r][c]
                        if val == max_in_row[r] && val == min_in_col[c] {
                                ans << Point{
                                        row: r + 1
                                        column: c + 1
                                }
                        }
                }
        }
        return ans
}
