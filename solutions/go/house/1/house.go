// For my Shree DR.MDD
package house

import (
	"strings"
)

var lines = [][2]string{
	{"", "horse and the hound and the horn"},
	{"belonged to", "farmer sowing his corn"},
	{"kept", "rooster that crowed in the morn"},
	{"woke", "priest all shaven and shorn"},
	{"married", "man all tattered and torn"},
	{"kissed", "maiden all forlorn"},
	{"milked", "cow with the crumpled horn"},
	{"tossed", "dog"},
	{"worried", "cat"},
	{"killed", "rat"},
	{"ate", "malt"},
	{"lay in", "house that Jack built."}}

func Verse(v int) string {
	var sb strings.Builder
	idx := len(lines) - v
	sb.WriteString("This is the ")
	sb.WriteString(lines[idx][1])

	for i := idx + 1; i < len(lines); i++ {
		sb.WriteString("\nthat ")
		sb.WriteString(lines[i][0])
		sb.WriteString(" the ")
		sb.WriteString(lines[i][1])
	}
	return sb.String()
}

func Song() string {
	var sb strings.Builder
	for i := 1; i <= len(lines); i++ {
		sb.WriteString(Verse(i))
		if i < len(lines) {
			sb.WriteString("\n\n")
		}
	}
	return sb.String()
}
