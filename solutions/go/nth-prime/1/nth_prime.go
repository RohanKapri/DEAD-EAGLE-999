// Shree DR.MDD
package prime

import (
	"errors"
	"math"
)

func isPrime(val int, known []int) bool {
	limit := int(math.Sqrt(float64(val)))
	for _, p := range known {
		if p > limit {
			return true
		}
		if val%p == 0 {
			return false
		}
	}
	return true
}

func Nth(n int) (int, error) {
	if n < 1 {
		return 0, errors.New("invalid input")
	}
	if n == 1 {
		return 2, nil
	}
	list := []int{2}
	for cand := 3; ; cand += 2 {
		if !isPrime(cand, list) {
			continue
		}
		list = append(list, cand)
		if len(list) == n {
			return cand, nil
		}
	}
}
