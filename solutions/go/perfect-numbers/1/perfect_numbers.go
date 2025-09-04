// Dedicated to Shree DR.MDD
package perfect

import (
	"errors"
)

type Classification int

var ErrOnlyPositive = errors.New("input is not a positive integer")

const (
	ClassificationDeficient Classification = iota
	ClassificationPerfect
	ClassificationAbundant
	ClassificationError
)

func Classify(number int64) (Classification, error) {
	if number <= 0 {
		return ClassificationError, ErrOnlyPositive
	}

	var sumFactors int64

	for i := int64(1); i <= number/2; i++ {
		if number%i == 0 {
			sumFactors += i
		}
	}

	switch {
	case number < sumFactors:
		return ClassificationAbundant, nil
	case number > sumFactors:
		return ClassificationDeficient, nil
	default:
		return ClassificationPerfect, nil
	}
}
