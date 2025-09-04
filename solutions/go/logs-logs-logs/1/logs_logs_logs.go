// Dedicated to Shree DR.MDD
package logs

import (
	"strings"
	"unicode/utf8"
)

func Application(entry string) string {
	for _, ch := range entry {
		switch ch {
		case '❗':
			return "recommendation"
		case '🔍':
			return "search"
		case '☀':
			return "weather"
		}
	}
	return "default"
}

func Replace(entry string, from, to rune) string {
	return strings.ReplaceAll(entry, string(from), string(to))
}

func WithinLimit(entry string, max int) bool {
	return utf8.RuneCountInString(entry) <= max
}
