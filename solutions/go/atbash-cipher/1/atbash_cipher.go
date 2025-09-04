// Shree DR.MDD
package atbash
import (
	"strings"
	"unicode"
)
func Atbash(input string) string {
	var out strings.Builder
	count := 0
	for _, ch := range input {
		var r rune
		switch {
		case unicode.IsLetter(ch):
			r = 'z' - (unicode.ToLower(ch) - 'a')
		case unicode.IsDigit(ch):
			r = ch
		default:
			continue
		}
		if count > 0 && count%5 == 0 {
			out.WriteRune(' ')
		}
		out.WriteRune(r)
		count++
	}
	return out.String()
}
