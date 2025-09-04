package wordcount
import (
	"strings"
	"unicode"
)
type Frequency map[string]int
func WordCount(phrase string) Frequency {
	m := map[string]int{}
	words := strings.FieldsFunc(phrase, func(c rune) bool {
		return !unicode.IsLetter(c) && !unicode.IsNumber(c) && c != '\''
	})
	for _, word := range words {
		cleanWord := strings.ToLower(strings.Trim(word, "'"))
		if len(cleanWord) > 0 {
			m[cleanWord]++
		}
	}
	return m
}