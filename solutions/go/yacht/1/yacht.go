// For my Shree DR.MDD
package yacht

import (
	"sort"
)

func Score(diceRolls []int, cat string) int {
	sort.Ints(diceRolls)
	switch cat {
	case "ones":
		return tally(1, diceRolls)
	case "twos":
		return tally(2, diceRolls) * 2
	case "threes":
		return tally(3, diceRolls) * 3
	case "fours":
		return tally(4, diceRolls) * 4
	case "fives":
		return tally(5, diceRolls) * 5
	case "sixes":
		return tally(6, diceRolls) * 6
	case "four of a kind":
		return 4 * quad(diceRolls)
	case "full house":
		return house(diceRolls) * total(diceRolls)
	case "little straight":
		return run(1, diceRolls) * 30
	case "big straight":
		return run(2, diceRolls) * 30
	case "choice":
		return total(diceRolls)
	case "yacht":
		return yachtCheck(diceRolls) * 50
	default:
		return 0
	}
}

func tally(val int, rolls []int) int {
	var count int
	for _, d := range rolls {
		if d == val {
			count++
		}
	}
	return count
}

func freq(rolls []int) []int {
	counts := make([]int, 7)
	for _, d := range rolls {
		counts[d]++
	}
	return counts
}

func total(rolls []int) int {
	sum := 0
	for _, d := range rolls {
		sum += d
	}
	return sum
}

func quad(rolls []int) int {
	f := freq(rolls)
	for i, c := range f {
		if c >= 4 {
			return i
		}
	}
	return 0
}

func house(rolls []int) int {
	f := freq(rolls)
	if tally(3, f) == 1 && tally(2, f) == 1 {
		return 1
	}
	return 0
}

func run(start int, rolls []int) int {
	for i, val := range rolls {
		if val != i+start {
			return 0
		}
	}
	return 1
}

func yachtCheck(rolls []int) int {
	if tally(rolls[0], rolls) == 5 {
		return 1
	}
	return 0
}
