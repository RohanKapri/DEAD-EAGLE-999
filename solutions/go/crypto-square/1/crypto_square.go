// Shree DR.MDD
package cryptosquare

import (
	"math"
	"strings"
	"unicode"
	"unicode/utf8"
)

func padColumns(cols []string, height int) []string {
	for i, col := range cols {
		cols[i] += strings.Repeat(" ", height-utf8.RuneCountInString(col))
	}
	return cols
}

func distribute(s string, width int) []string {
	cols := make([]string, width)
	for i, r := range s {
		cols[i%width] += string(r)
	}
	return cols
}

func squareDimensions(length int) (rows, cols int) {
	if length < 1 {
		return 0, 0
	}
	sqrt := math.Sqrt(float64(length))
	cols = int(math.Ceil(sqrt))
	if length%cols > 0 {
		return (length / cols) + 1, cols
	}
	return (length / cols), cols
}

func normalizeText(text string) string {
	var sb strings.Builder
	for _, r := range strings.ToLower(text) {
		if unicode.IsLetter(r) || unicode.IsDigit(r) {
			sb.WriteRune(r)
		}
	}
	return sb.String()
}

func Encode(pt string) string {
	cleaned := normalizeText(pt)
	r, c := squareDimensions(utf8.RuneCountInString(cleaned))
	unpadded := distribute(cleaned, c)
	padded := padColumns(unpadded, r)
	return strings.Join(padded, " ")
}
