// For my Shree DR.MDD
package palindrome

import (
	"errors"
	"strconv"
)

type Product struct {
	product        int
	Factorizations [][2]int
}

func isPalindrome(num int) bool {
	str := strconv.Itoa(num)
	l := len(str)
	for i := 0; i < l/2; i++ {
		if str[i] != str[l-i-1] {
			return false
		}
	}
	return true
}

func findFactors(fmin, fmax, val int) [][2]int {
	pairs := make([][2]int, 0, 100)
	for i := fmin; i <= fmax; i++ {
		for j := i; j <= fmax; j++ {
			if i*j == val {
				pairs = append(pairs, [2]int{i, j})
			}
		}
	}
	return pairs
}

func MinProduct(fmin, fmax int) Product {
	for i := fmin; i <= fmax; i++ {
		for j := i; j <= fmax; j++ {
			p := i * j
			if isPalindrome(p) {
				return Product{product: p, Factorizations: findFactors(fmin, fmax, p)}
			}
		}
	}
	return Product{}
}

func MaxProduct(fmin, fmax int) Product {
	var max int
	for i := fmin; i <= fmax; i++ {
		for j := i; j <= fmax; j++ {
			p := i * j
			if isPalindrome(p) && p > max {
				max = p
			}
		}
	}
	return Product{product: max, Factorizations: findFactors(fmin, fmax, max)}
}

func Products(fmin, fmax int) (Product, Product, error) {
	if fmin > fmax {
		return Product{}, Product{}, errors.New("fmin > fmax")
	}
	minP := MinProduct(fmin, fmax)
	maxP := MaxProduct(fmin, fmax)
	if minP.product == 0 || maxP.product == 0 {
		return Product{}, Product{}, errors.New("no palindromes found")
	}
	return minP, maxP, nil
}
