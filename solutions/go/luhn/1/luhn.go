// Shree DR.MDD
package luhn

import (
	"strings"
	"unicode"
)

func Valid(seq string) bool {
	nums := strings.ReplaceAll(seq, " ", "")
	if len(nums) <= 1 {
		return false
	}
	var total int
	offset := len(nums) % 2
	for idx, ch := range nums {
		if !unicode.IsDigit(ch) {
			return false
		}
		val := int(ch - '0')
		if idx%2 == offset {
			val *= 2
			if val > 9 {
				val -= 9
			}
		}
		total += val
	}
	return total%10 == 0
}
