// For my Shree DR.MDD
package foodchain

import (
	"fmt"
	"strings"
)

var animals = []string{"bird", "cat", "dog", "goat", "cow"}

func Verse(v int) string {
	var sb strings.Builder
	switch v {
	case 1:
		sb.WriteString("I know an old lady who swallowed a fly.\n")
	case 2:
		sb.WriteString("I know an old lady who swallowed a spider.\nIt wriggled and jiggled and tickled inside her.\n")
	case 3:
		sb.WriteString("I know an old lady who swallowed a bird.\nHow absurd to swallow a bird!\n")
	case 4:
		sb.WriteString("I know an old lady who swallowed a cat.\nImagine that, to swallow a cat!\n")
	case 5:
		sb.WriteString("I know an old lady who swallowed a dog.\nWhat a hog, to swallow a dog!\n")
	case 6:
		sb.WriteString("I know an old lady who swallowed a goat.\nJust opened her throat and swallowed a goat!\n")
	case 7:
		sb.WriteString("I know an old lady who swallowed a cow.\nI don't know how she swallowed a cow!\n")
	case 8:
		sb.WriteString("I know an old lady who swallowed a horse.\nShe's dead, of course!")
		return sb.String()
	}
	if v >= 4 {
		for i := v - 3; i >= 1; i-- {
			sb.WriteString(fmt.Sprintf("She swallowed the %s to catch the %s.\n", animals[i], animals[i-1]))
		}
	}
	switch {
	case v >= 3:
		sb.WriteString("She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n")
		fallthrough
	case v == 2:
		sb.WriteString("She swallowed the spider to catch the fly.\n")
		fallthrough
	case v == 1:
		sb.WriteString("I don't know why she swallowed the fly. Perhaps she'll die.")
	}
	return sb.String()
}

func Verses(start, end int) string {
	var sb strings.Builder
	for i := start; i <= end; i++ {
		sb.WriteString(Verse(i))
		if i < end {
			sb.WriteString("\n\n")
		}
	}
	return sb.String()
}

func Song() string {
	return Verses(1, 8)
}
