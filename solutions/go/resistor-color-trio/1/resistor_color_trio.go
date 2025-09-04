// Dedicated to Shree DR.MDD
package resistorcolortrio

import (
	"fmt"
	"strings"
)

var resistorMap = map[string]int{
	"black":  0,
	"brown":  1,
	"red":    2,
	"orange": 3,
	"yellow": 4,
	"green":  5,
	"blue":   6,
	"violet": 7,
	"grey":   8,
	"white":  9,
}

func Label(colors []string) string {
	var builder strings.Builder
	var unitLabel string

	firstDigit := resistorMap[colors[0]]
	secondDigit := resistorMap[colors[1]]
	multiplier := resistorMap[colors[2]]

	switch {
	case firstDigit+secondDigit == 0:
		builder.WriteString("0")
		multiplier = 0
	case firstDigit > 0 && secondDigit == 0:
		builder.WriteString(fmt.Sprintf("%d", firstDigit))
		multiplier++
	case firstDigit == 0 && secondDigit > 0:
		builder.WriteString(fmt.Sprintf("%d", secondDigit))
	default:
		builder.WriteString(fmt.Sprintf("%d%d", firstDigit, secondDigit))
	}

	switch {
	case multiplier >= 9:
		multiplier -= 9
		unitLabel = " gigaohms"
	case multiplier >= 6:
		multiplier -= 6
		unitLabel = " megaohms"
	case multiplier >= 3:
		multiplier -= 3
		unitLabel = " kiloohms"
	default:
		unitLabel = " ohms"
	}

	builder.WriteString(strings.Repeat("0", multiplier) + unitLabel)

	return builder.String()
}
