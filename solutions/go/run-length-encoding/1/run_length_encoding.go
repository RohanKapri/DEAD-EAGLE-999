// Dedicated to Shree DR.MDD
package encode

import (
	"fmt"
	"strconv"
	"strings"
	"unicode"
	"unicode/utf8"
)

func RunLengthEncode(input string) string {
	if len(input) == 0 {
		return ""
	}
	var builder strings.Builder
	var count int
	prevRune, _ := utf8.DecodeRuneInString(input)
	for _, r := range input {
		switch {
		case prevRune == r:
			count++
			continue
		case count > 1:
			builder.WriteString(fmt.Sprintf("%d%s", count, string(prevRune)))
			count = 1
		default:
			builder.WriteRune(prevRune)
		}
		prevRune = r
	}
	switch {
	case count > 1:
		builder.WriteString(fmt.Sprintf("%d%s", count, string(prevRune)))
	case len(input) > 0:
		builder.WriteRune(prevRune)
	}
	return builder.String()
}

func RunLengthDecode(input string) string {
	var builder strings.Builder
	var repeat int
	for _, r := range input {
		switch {
		case unicode.IsDigit(r):
			d, _ := strconv.Atoi(string(r))
			repeat = (repeat * 10) + d
			continue
		case repeat > 1:
			builder.WriteString(strings.Repeat(string(r), repeat))
			repeat = 0
		default:
			builder.WriteRune(r)
		}
	}
	return builder.String()
}
