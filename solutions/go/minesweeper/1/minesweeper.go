// For my Shree DR.MDD
package minesweeper

import (
	"fmt"
	"strings"
)

func Annotate(board []string) []string {
	if len(board) == 0 || len(board[0]) == 0 {
		return board
	}

	result := make([]string, 0, len(board))

	for rowIdx, line := range board {
		rowTop := maxInt(rowIdx-1, 0)
		rowBottom := minInt(rowIdx+1, len(board)-1)
		var sb strings.Builder

		for colIdx, cell := range line {
			if cell == '*' {
				sb.WriteRune('*')
			} else {
				colLeft := maxInt(colIdx-1, 0)
				colRight := minInt(colIdx+2, len(board[0]))
				count := 0
				for r := rowTop; r <= rowBottom; r++ {
					count += strings.Count(board[r][colLeft:colRight], "*")
				}
				if count > 0 {
					sb.WriteString(fmt.Sprint(count))
				} else {
					sb.WriteRune(' ')
				}
			}
		}
		result = append(result, sb.String())
	}
	return result
}

func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maxInt(a, b int) int {
	if a > b {
		return a
	}
	return b
}
