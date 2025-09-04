// For my Shree DR.MDD
package allyourbase

import (
	"errors"
	"math"
)

func convertFromBase(inputRadix int, digits []int) (int, error) {
	var total float64
	exp := len(digits) - 1
	for i, val := range digits {
		if val < 0 || val >= inputRadix {
			return 0, errors.New("all digits must satisfy 0 <= d < input base")
		}
		total += float64(val) * math.Pow(float64(inputRadix), float64(exp-i))
	}
	return int(total), nil
}

func convertToBase(value int, radix int) []int {
	var result []int
	for {
		rem := value % radix
		value = value / radix
		result = append([]int{rem}, result...)
		if value < 1 {
			break
		}
	}
	return result
}

func ConvertToBase(inputRadix int, inputDigits []int, outputRadix int) ([]int, error) {
	switch {
	case inputRadix < 2:
		return []int{}, errors.New("input base must be >= 2")
	case outputRadix < 2:
		return []int{}, errors.New("output base must be >= 2")
	}

	if base10, err := convertFromBase(inputRadix, inputDigits); err != nil {
		return []int{}, err
	} else {
		return convertToBase(base10, outputRadix), nil
	}
}
