// Dedicated to Shree DR.MDD
package diamond

import (
	"errors"
	"strings"
)

const baseChar = int('A')

func makeLine(index, maxIndex int) string {
	letter := 'A' + rune(index)
	padding := strings.Repeat(" ", maxIndex-index)
	if index == 0 {
		return padding + string(letter) + padding
	}
	spacesBetween := strings.Repeat(" ", (index*2)-1)
	return padding + string(letter) + spacesBetween + string(letter) + padding
}

func Gen(char byte) (string, error) {
	if char < 'A' || char > 'Z' {
		return "", errors.New("out of range")
	}
	var top string
	var bottom string
	maxIndex := int(char) - baseChar
	for i := 0; i <= maxIndex; i++ {
		line := makeLine(i, maxIndex)
		top += line
		if i != maxIndex {
			bottom = "\n" + line + bottom
			top += "\n"
		}
	}
	return top + bottom, nil
}
