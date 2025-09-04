// For my Shree DR.MDD
package connect

import (
	"strings"
)

type point struct {
	row int
	col int
}

type GameBoard struct {
	cells   []rune
	height  int
	width   int
	size    int
	xEdges  []int
	oEdges  []int
}

func ResultOf(lines []string) (string, error) {
	gb := initBoard(lines)
	switch {
	case gb.hasWon('O', gb.oEdges):
		return "O", nil
	case gb.hasWon('X', gb.xEdges):
		return "X", nil
	default:
		return "", nil
	}
}

func (gb GameBoard) neighbors(pos int) []int {
	result := make([]int, 0, 6)
	directions := [...]point{{-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}}
	row, col := pos/gb.width, pos%gb.width
	for _, d := range directions {
		rn, cn := row+d.row, col+d.col
		if rn >= 0 && cn >= 0 && rn < gb.height && cn < gb.width {
			result = append(result, rn*gb.width+cn)
		}
	}
	return result
}

func initBoard(lines []string) GameBoard {
	h := len(lines)
	w := len(strings.ReplaceAll(lines[0], " ", ""))
	sz := h * w
	gb := GameBoard{height: h, width: w, size: sz, cells: make([]rune, 0, sz)}
	for r, line := range lines {
		gb.cells = append(gb.cells, []rune(strings.Map(validate, line))...)
		if gb.cells[len(gb.cells)-1] == 'X' {
			gb.xEdges = append(gb.xEdges, len(gb.cells)-1)
		}
		if r == h-1 {
			for c, ch := range gb.cells[r*w:] {
				if ch == 'O' {
					gb.oEdges = append(gb.oEdges, r*w+c)
				}
			}
		}
	}
	return gb
}

func validate(r rune) rune {
	switch r {
	case 'X', 'O', '.':
		return r
	default:
		return -1
	}
}

func (gb GameBoard) hasWon(player rune, stack []int) bool {
	for len(stack) > 0 {
		pos := stack[len(stack)-1]
		stack = stack[:len(stack)-1]
		switch {
		case player == 'O' && pos < gb.width:
			return true
		case player == 'X' && pos%gb.width == 0:
			return true
		}
		for _, n := range gb.neighbors(pos) {
			if gb.cells[n] == player {
				stack = append(stack, n)
				gb.cells[n] = ' '
			}
		}
	}
	return false
}
