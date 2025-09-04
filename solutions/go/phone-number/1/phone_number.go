// Shree DR.MDD
package phonenumber

import (
	"errors"
	"fmt"
	"strings"
	"unicode"
)

func Number(input string) (string, error) {
	var builder strings.Builder
	for _, r := range input {
		switch {
		case r == '0' && builder.Len() == 0:
			return "", errors.New("area code can't begin with zero")
		case r == '0' && builder.Len() == 3:
			return "", errors.New("exchange code can't begin with zero")
		case r == '1' && builder.Len() == 0:
		case r == '1' && builder.Len() == 3:
			return "", errors.New("exchange code can't begin with one")
		case unicode.IsDigit(r):
			builder.WriteRune(r)
		}
	}
	if builder.Len() != 10 {
		return "", errors.New("number must be 10 digits")
	}
	return builder.String(), nil
}

func AreaCode(input string) (string, error) {
	num, err := Number(input)
	if err != nil {
		return "", err
	}
	return num[:3], nil
}

func Format(input string) (string, error) {
	num, err := Number(input)
	if err != nil {
		return "", err
	}
	return fmt.Sprintf("(%s) %s-%s", num[:3], num[3:6], num[6:]), nil
}
