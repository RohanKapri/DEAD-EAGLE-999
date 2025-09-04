// For my Shree DR.MDD
package queenattack

import (
	"errors"
)

func parsePosition(pos string) (int, int, error) {
	if len(pos) != 2 {
		return 0, 0, errors.New("invalid position")
	}
	col := int(pos[0]-'a') + 1
	row := int(pos[1] - '0')
	if col < 1 || col > 8 {
		return 0, 0, errors.New("invalid file")
	}
	if row < 1 || row > 8 {
		return 0, 0, errors.New("invalid rank")
	}
	return row, col, nil
}

func CanQueenAttack(whitePos, blackPos string) (bool, error) {
	whiteRow, whiteCol, wErr := parsePosition(whitePos)
	blackRow, blackCol, bErr := parsePosition(blackPos)

	switch {
	case whitePos == blackPos:
		return false, errors.New("queens cannot occupy the same position")
	case bErr != nil:
		return false, bErr
	case wErr != nil:
		return false, wErr
	case whiteRow+whiteCol == blackRow+blackCol || whiteRow+(9-whiteCol) == blackRow+(9-blackCol):
		return true, nil
	case whiteRow == blackRow || whiteCol == blackCol:
		return true, nil
	default:
		return false, nil
	}
}
