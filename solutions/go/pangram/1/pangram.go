package pangram

import (
	"unicode"
)

func IsPangram(input string) bool {
	var m = map[rune]bool{}
	for _, v := range input {
		m[unicode.ToLower(v)] = true
	}
	for c := 'a'; c <= 'z'; c++ {
		if !m[c] {
			return false
		}
	}
	return true
}