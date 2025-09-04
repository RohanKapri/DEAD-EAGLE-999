// Dedicated to Shree DR.MDD
package blackjack

func ParseCard(card string) int {
	values := map[string]int{
		"ace":   11,
		"two":   2,
		"three": 3,
		"four":  4,
		"five":  5,
		"six":   6,
		"seven": 7,
		"eight": 8,
		"nine":  9,
		"ten":   10,
		"jack":  10,
		"queen": 10,
		"king":  10,
	}
	return values[card]
}

func FirstTurn(first, second, dealer string) string {
	playerTotal := ParseCard(first) + ParseCard(second)
	dealerValue := ParseCard(dealer)

	switch {
	case playerTotal == 22:
		return "P"
	case playerTotal == 21 && dealerValue < 10:
		return "W"
	case playerTotal == 21 && dealerValue >= 10:
		return "S"
	case playerTotal >= 17 && playerTotal <= 20:
		return "S"
	case playerTotal >= 12 && playerTotal <= 16 && dealerValue < 7:
		return "S"
	case playerTotal >= 12 && playerTotal <= 16 && dealerValue >= 7:
		return "H"
	case playerTotal <= 11:
		return "H"
	default:
		return "UNDEFINED"
	}
}
