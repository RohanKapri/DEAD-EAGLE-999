package isbn

import "unicode"

func IsValidISBN(isbn string) bool {
	var weight int = 10
	var total int
	for _, digit := range isbn {
		var value int
		if unicode.IsDigit(digit) {
			value = int(digit - '0')
		} else if digit == 'X' && weight == 1 {
			value = 10
		} else if digit == '-' {
			continue
		} else {
			break
		}
		total += value * weight
		weight--
	}
	return total%11 == 0 && weight == 0
}