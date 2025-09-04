package reverse

import "unicode/utf8"

func Reverse(input string) string {
	l := utf8.RuneCountInString(input)
	letters := make([]rune, l)
	for i, letter := range []rune(input) {
		letters[l-1-i] = letter
	}
	return string(letters)
}