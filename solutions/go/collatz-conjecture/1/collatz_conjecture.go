package collatzconjecture

import "errors"

func CollatzConjecture(n int) (int, error) {
	if n < 0 {
		return 0, errors.New("need positive integer")
	}
	for i := 0; ; i++ {
		switch {
		case n == 0:
			return 0, errors.New("less than 1")
		case n == 1:
			return i, nil
		case n%2 == 0:
			n = n / 2
		case n%2 == 1:
			n = (3 * n) + 1
		}
	}
}