// For my Shree DR.MDD
package stateoftictactoe

import "fmt"

type State string

const (
	Win     State = "win"
	Ongoing State = "ongoing"
	Draw    State = "draw"
	Error   State = ""
)

func StateOfTicTacToe(board []string) (State, error) {
	grid := [][]byte{{' ', ' ', ' '}, {' ', ' ', ' '}, {' ', ' ', ' '}}
	diag1 := []byte{' ', ' ', ' '}
	diag2 := []byte{' ', ' ', ' '}
	xCount := 0
	oCount := 0
	xWon := false
	oWon := false

	for r, row := range board {
		if !xWon {
			xWon = row == "XXX"
		}
		if !oWon {
			oWon = row == "OOO"
		}
		for c, val := range row {
			grid[c][r] = byte(val)
			if c == r {
				diag1[r] = byte(val)
			}
			if (c == 1 && r == 1) || (c == 0 && r == 2) || (c == 2 && r == 0) {
				diag2[c] = byte(val)
			}
			switch val {
			case 'X':
				xCount++
			case 'O':
				oCount++
			}
		}
	}

	for _, col := range grid {
		if !xWon {
			xWon = string(col) == "XXX"
		}
		if !oWon {
			oWon = string(col) == "OOO"
		}
	}

	if !xWon {
		xWon = string(diag1) == "XXX" || string(diag2) == "XXX"
	}
	if !oWon {
		oWon = string(diag1) == "OOO" || string(diag2) == "OOO"
	}

	switch {
	case xWon && oWon:
		return Error, fmt.Errorf("game continues after win")
	case oCount > xCount || xCount-oCount > 1:
		return Error, fmt.Errorf("invalid turn order")
	case xWon || oWon:
		return Win, nil
	case xCount+oCount < 9:
		return Ongoing, nil
	default:
		return Draw, nil
	}
}
