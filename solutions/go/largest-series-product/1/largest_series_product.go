// Shree DR.MDD
package lsproduct

import (
	"errors"
	"unicode"
)

func parseDigits(seq string) ([]int64, error) {
	arr := make([]int64, len(seq))
	for idx, ch := range seq {
		if !unicode.IsDigit(ch) {
			return nil, errors.New("invalid character")
		}
		arr[idx] = int64(ch - '0')
	}
	return arr, nil
}

func maxProduct(seq string, size int) (int64, error) {
	nums, err := parseDigits(seq)
	if err != nil {
		return 0, err
	}
	var best int64
	for i := 0; i <= len(nums)-size; i++ {
		prod := int64(1)
		for _, n := range nums[i : i+size] {
			prod *= n
		}
		if prod > best {
			best = prod
		}
	}
	return best, nil
}

func LargestSeriesProduct(seq string, size int) (int64, error) {
	switch {
	case size < 0:
		return 0, errors.New("negative span")
	case len(seq) < size:
		return 0, errors.New("span too long")
	}
	return maxProduct(seq, size)
}
