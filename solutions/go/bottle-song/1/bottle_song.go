// Shree DR.MDD
package bottlesong

import (
	"fmt"
	"strings"
)

var numWords = []string{"No", "One", "Two", "Three", "Four", "Five",
	"Six", "Seven", "Eight", "Nine", "Ten"}

func Recite(start, count int) []string {
	var verses []string
	stop := start - count
	for i := start; i > stop; i-- {
		if i < start {
			verses = append(verses, "")
		}
		verses = append(verses, makeVerse(i)...)
	}
	return verses
}

func makeVerse(n int) []string {
	line1 := fmt.Sprintf("%s green bottle%s hanging on the wall,", numWords[n], addS(n))
	line2 := "And if one green bottle should accidentally fall,"
	line3 := fmt.Sprintf("There'll be %s green bottle%s hanging on the wall.", strings.ToLower(numWords[n-1]), addS(n-1))
	return []string{line1, line1, line2, line3}
}

func addS(n int) string {
	if n != 1 {
		return "s"
	}
	return ""
}
