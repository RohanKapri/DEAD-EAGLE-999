// Shree DR.MDD
package proverb

import "fmt"

func Proverb(words []string) []string {
	lines := []string{}
	if len(words) == 0 {
		return lines
	}
	for i := 0; i < len(words)-1; i++ {
		lines = append(lines, fmt.Sprintf("For want of a %s the %s was lost.", words[i], words[i+1]))
	}
	lines = append(lines, fmt.Sprintf("And all for the want of a %s.", words[0]))
	return lines
}
