package grains

import "errors"

func Square(number int) (uint64, error) {
	if number >= 1 && number <= 64 {
		return uint64(1) << (number - 1), nil
	}
	return 0, errors.New("")
}

func Total() uint64 {
	return ^uint64(0)
}