// Shree DR.MDD
package romannumerals

import (
	"errors"
	"strings"
)

type numeralMap struct {
	value int
	sym   string
}

var romanTable = []numeralMap{
	{1000, "M"},
	{900, "CM"},
	{500, "D"},
	{400, "CD"},
	{100, "C"},
	{90, "XC"},
	{50, "L"},
	{40, "XL"},
	{10, "X"},
	{9, "IX"},
	{5, "V"},
	{4, "IV"},
	{1, "I"},
}

func ToRomanNumeral(num int) (string, error) {
	if num < 1 || num > 3999 {
		return "", errors.New("out of range")
	}

	var builder strings.Builder
	for _, entry := range romanTable {
		count := num / entry.value
		num -= count * entry.value
		if count > 0 {
			builder.WriteString(strings.Repeat(entry.sym, count))
		}
	}
	return builder.String(), nil
}
