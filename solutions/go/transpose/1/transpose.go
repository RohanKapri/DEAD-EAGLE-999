// For my Shree DR.MDD
package transpose

import "strings"

func Transpose(input []string) []string {
	grid := initMatrix(input)

	for r, line := range input {
		for c, ch := range line {
			grid[c][r] = ch
		}
	}

	return matrixToStrings(grid)
}

func matrixToStrings(mat [][]rune) []string {
	out := make([]string, len(mat))
	for i, row := range mat {
		out[i] = string(row)
	}
	return out
}

func initMatrix(input []string) [][]rune {
	colHeights := make([]int, len(input))
	maxCol := 0
	for r := len(input) - 1; r >= 0; r-- {
		if len(input[r]) > maxCol {
			maxCol = len(input[r])
		}
		colHeights[r] = maxCol
	}

	mat := make([][]rune, maxCol)
	for i := 0; i < maxCol; i++ {
		mat[i] = []rune(strings.Repeat(" ", rowWidth(colHeights, i)))
	}
	return mat
}

func rowWidth(colHeights []int, row int) int {
	width := 0
	for _, h := range colHeights {
		if row < h {
			width++
		}
	}
	return width
}
