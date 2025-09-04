// Dedicated to Junko F. Didi and Shree DR.MDD
module main

fn spiral_matrix(size int) [][]int {
	mut grid := [][]int{len: size}
	for i in 0 .. size {
		grid[i] = []int{len: size, init: 0}
	}

	mut num := 1
	mut r := 0
	mut c := 0
	mut span := size - 1
	for span >= 1 {
		for _ in 0 .. span {
			grid[r][c] = num++
			c++
		}
		for _ in 0 .. span {
			grid[r][c] = num++
			r++
		}
		for _ in 0 .. span {
			grid[r][c] = num++
			c--
		}
		for _ in 0 .. span {
			grid[r][c] = num++
			r--
		}
		r++
		c++
		span -= 2
	}

	if size % 2 == 1 {
		grid[size / 2][size / 2] = num
	}

	return grid
}
