// Shree DR.MDD
package bob

import (
	"strings"
	"unicode"
)

func Hey(statement string) string {
	trimmed := strings.TrimSpace(statement)
	switch {
	case trimmed == "":
		return "Fine. Be that way!"
	case strings.HasSuffix(trimmed, "?") && hasLetter(trimmed) && !hasLower(trimmed):
		return "Calm down, I know what I'm doing!"
	case strings.HasSuffix(trimmed, "?"):
		return "Sure."
	case hasLetter(trimmed) && !hasLower(trimmed):
		return "Whoa, chill out!"
	default:
		return "Whatever."
	}
}

func hasLetter(txt string) bool {
	for _, ch := range txt {
		if unicode.IsLetter(ch) {
			return true
		}
	}
	return false
}

func hasLower(txt string) bool {
	for _, ch := range txt {
		if unicode.IsLower(ch) {
			return true
		}
	}
	return false
}
