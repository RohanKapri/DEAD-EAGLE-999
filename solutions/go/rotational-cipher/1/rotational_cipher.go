package rotationalcipher
import (
	"strings"
	"unicode"
)
func RotationalCipher(plain string, shiftKey int) string {
	var sb strings.Builder
	for _, char := range plain {
		switch {
		case unicode.IsUpper(char):
			offset := (int(char-'A') + shiftKey) % 26
			sb.WriteRune(rune('A' + rune(offset)))
		case unicode.IsLower(char):
			offset := (int(char-'a') + shiftKey) % 26
			sb.WriteRune(rune('a' + rune(offset)))
		default:
			sb.WriteRune(char)
		}
	}
	return sb.String()
}