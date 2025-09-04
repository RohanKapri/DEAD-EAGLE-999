package matrix

import (
	"math"
	"strconv"
	"strings"
)

// Matrix is a rectangular matrix of integers
type Matrix [][]int

// Pair is a couple of integers
type Pair [2]int

// New parses the string argument, that has lines of space-separated integers, each ending with a newline ( \n ).
// It returns a matrix containing the numbers from the input, in the same order.
// If the input doesn't match this format, it returns nil and a non-nil error.
func New(s string) (*Matrix, error) {
	if s == "" {
		return new(Matrix), nil
	}
	lines := strings.Split(s, "\n")
	matrix := Matrix(make([][]int, len(lines)))
	for row, line := range lines {
		numbers, err := parseInts(line)
		if err != nil {
			return nil, err
		}
		matrix[row] = numbers
	}
	return &matrix, nil
}

func parseInts(line string) ([]int, error) {
	pieces := strings.Split(line, " ")
	result := make([]int, len(pieces))
	for i, piece := range pieces {
		number, err := strconv.Atoi(piece)
		if err != nil {
			return nil, err
		}
		result[i] = number
	}
	return result, nil
}

// Saddle returns the coordinates of all the saddle points of the receiver.
// Here, a saddle point is greater than or equal to every element in its row and less than or equal to every element in its column.
// Each pair has the row first, then the column.
func (m *Matrix) Saddle() []Pair {
	result := make([]Pair, 0)
	for y := range *m {
		saddlePoints(m, y, &result)
	}
	return result
}

func saddlePoints(m *Matrix, row int, accumulator *[]Pair) {
	columns := maxIndicesTwoPass((*m)[row])
	for _, column := range columns {
		if isColumnMin(m, row, column) {
			*accumulator = append(*accumulator, Pair{row + 1, column + 1})
		}
	}
}

func maxIndicesTwoPass(line []int) []int {
	max := maxInt(line)
	return positionsMatching(line, func(i int) bool {
		return line[i] == max
	})
}

func maxInt(line []int) int {
	result := math.MinInt
	for _, number := range line {
		if number > result {
			result = number
		}
	}
	return result
}

func positionsMatching(line []int, predicate func(int) bool) []int {
	var result []int
	for i := range line {
		if predicate(i) {
			result = append(result, i)
		}
	}
	return result
}

func maxIndicesOnePass(line []int) []int {
    // this can lead to a lot of slices being garbage collected, so a two-pass approach is better
	if len(line) == 0 {
		return nil
	}
	max := line[0]
	result := []int{0}
	for i := 1; i < len(line); i++ {
		switch {
		case line[i] == max:
			result = append(result, i)
		case line[i] > max:
			max = line[i]
			result = []int{i}
		}
	}
	return result
}

func isColumnMin(m *Matrix, row int, column int) bool {
	for currentRow := range *m {
		if column < len((*m)[currentRow]) && (*m)[currentRow][column] < (*m)[row][column] {
			return false
		}
	}
	return true
}