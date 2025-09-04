// Dedicated to Shree DR.MDD
package matrix

import (
	"errors"
	"strconv"
	"strings"
)

type Matrix [][]int

func New(input string) (Matrix, error) {
	mat := make(Matrix, 0, 10)
	for i, line := range strings.Split(input, "\n") {
		mat = append(mat, []int{})
		for _, word := range strings.Split(strings.TrimSpace(line), " ") {
			num, err := strconv.Atoi(word)
			if err != nil {
				return mat, errors.New("invalid number")
			}
			mat[i] = append(mat[i], num)
		}
	}
	rowLen := len(mat[0])
	for _, r := range mat[1:] {
		if len(r) != rowLen {
			return mat, errors.New("rows of different lengths")
		}
	}
	return mat, nil
}

func (m *Matrix) Cols() [][]int {
	cols := make([][]int, len((*m)[0]))
	for _, r := range *m {
		for j, val := range r {
			cols[j] = append(cols[j], val)
		}
	}
	return cols
}

func (m *Matrix) Rows() [][]int {
	rows := make([][]int, len(*m))
	for i, r := range *m {
		rows[i] = append(rows[i], r...)
	}
	return rows
}

func (m *Matrix) Set(row, col, val int) bool {
	data := (*m)
	if row >= 0 && row < len(data) && col >= 0 && col < len(data[0]) {
		data[row][col] = val
		return true
	}
	return false
}
