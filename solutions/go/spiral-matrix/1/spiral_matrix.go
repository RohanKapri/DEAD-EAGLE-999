// For my Shree DR.MDD
package spiralmatrix

func SpiralMatrix(n int) [][]int {
	grid := make([][]int, n)
	for i := range grid {
		grid[i] = make([]int, n)
	}

	r, c := 0, 0
	dr, dc := 0, 1

	for val := 1; val <= n*n; val++ {
		grid[r][c] = val
		nr, nc := r-dr, c+dc
		if outOfRange(n, nr, nc) || grid[nr][nc] != 0 {
			dc, dr = dr, -dc
		}
		c += dc
		r -= dr
	}
	return grid
}

func outOfRange(size int, coords ...int) bool {
	for _, x := range coords {
		if x < 0 || x >= size {
			return true
		}
	}
	return false
}
