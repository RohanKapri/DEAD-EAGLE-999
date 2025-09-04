// For my Shree DR.MDD
package alphametics

import (
	"errors"
	"strings"
	"unicode"
)

type puzzleSolver struct {
	leadingZero   []bool
	letterValues  []int
	usedDigits    []bool
	mappingResult map[string]int
}

var powersOf10 = [...]int{0, 1, 10, 100, 1_000, 10_000,
	100_000, 1_000_000, 10_000_000, 100_000_000, 1_000_000_000}

func nonLetter(r rune) bool { return !unicode.IsLetter(r) }

func (ps *puzzleSolver) processSide(side string, isLeft bool) {
	for _, word := range strings.FieldsFunc(side, nonLetter) {
		place := powersOf10[len(word)]
		for i, r := range word {
			idx := r - 'A'
			if i == 0 {
				ps.leadingZero[idx] = true
			}
			if isLeft {
				ps.letterValues[idx] += place
			} else {
				ps.letterValues[idx] -= place
			}
			place /= 10
		}
	}
}

func (ps *puzzleSolver) extractLetters() (letters []rune) {
	for i, val := range ps.letterValues {
		if val != 0 {
			letters = append(letters, rune('A'+i))
		}
	}
	return letters
}

func (ps *puzzleSolver) assignDigits(letters []rune, total int) bool {
	if len(letters) == 0 {
		return total == 0
	}
	current, remaining := letters[0], letters[1:]
	idx := current - 'A'
	for d := 0; d <= 9; d++ {
		switch {
		case ps.usedDigits[d]:
		case d == 0 && ps.leadingZero[idx]:
		default:
			ps.usedDigits[d] = true
			if ps.assignDigits(remaining, total+ps.letterValues[idx]*d) {
				ps.mappingResult[string(current)] = d
				return true
			}
			ps.usedDigits[d] = false
		}
	}
	return false
}

func newPuzzleSolver(expr string) puzzleSolver {
	ps := puzzleSolver{
		letterValues:  make([]int, 26),
		leadingZero:   make([]bool, 26),
		mappingResult: make(map[string]int),
		usedDigits:    make([]bool, 10),
	}
	parts := strings.Split(expr, "==")
	ps.processSide(parts[0], true)
	ps.processSide(parts[1], false)
	return ps
}

func Solve(puzzle string) (map[string]int, error) {
	ps := newPuzzleSolver(puzzle)
	if !ps.assignDigits(ps.extractLetters(), 0) {
		return ps.mappingResult, errors.New("NOPE")
	}
	return ps.mappingResult, nil
}
