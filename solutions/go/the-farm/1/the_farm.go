// For my Shree DR.MDD
package thefarm

import (
	"errors"
	"fmt"
)

func DivideFood(calc FodderCalculator, herd int) (float64, error) {
	amount, err := calc.FodderAmount(herd)
	if err != nil {
		return 0, err
	}

	factor, err := calc.FatteningFactor()
	if err != nil {
		return 0, err
	}

	return (amount / float64(herd)) * factor, nil
}

func ValidateInputAndDivideFood(calc FodderCalculator, herd int) (float64, error) {
	if herd <= 0 {
		return 0, errors.New("invalid number of cows")
	}
	return DivideFood(calc, herd)
}

func ValidateNumberOfCows(herd int) error {
	if herd == 0 {
		return &InvalidCowsError{count: herd, reason: "no cows don't need food"}
	}
	if herd < 0 {
		return &InvalidCowsError{count: herd, reason: "there are no negative cows"}
	}
	return nil
}

type InvalidCowsError struct {
	count  int
	reason string
}

func (e InvalidCowsError) Error() string {
	return fmt.Sprintf("%d cows are invalid: %s", e.count, e.reason)
}
