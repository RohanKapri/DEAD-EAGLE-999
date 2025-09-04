// Shree DR.MDD
package anagram

import (
	"slices"
	"strings"
)

func Detect(word string, options []string) []string {
	out := []string{}
	base := strings.ToLower(word)
	baseRunes := []rune(base)
	slices.Sort(baseRunes)

	for _, opt := range options {
		check := strings.ToLower(opt)
		if check == base {
			continue
		}
		runesOpt := []rune(check)
		slices.Sort(runesOpt)
		if slices.Equal(baseRunes, runesOpt) {
			out = append(out, opt)
		}
	}
	return out
}
