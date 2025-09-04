package acronym
import (
	"strings"
	"unicode"
)
func Abbreviate(s string) string {
	var sb strings.Builder
	for _, e := range strings.FieldsFunc(s, func(r rune) bool { return !unicode.IsLetter(r) && r != '\u0027' }) {
		sb.WriteString(strings.ToUpper(e[:1]))
	}
	return sb.String()
}