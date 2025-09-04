package sieve

func Sieve(limit int) []int {
	notPrimes := make([]bool, limit+1)
	for i := 2; i <= limit; i += 1 {
		if !notPrimes[i] {
			for j := i * 2; j <= limit; j += i {
				notPrimes[j] = true
			}
		}
	}
	primes := make([]int, 0, limit/2)
	for i, v := range notPrimes {
		if !v {
			primes = append(primes, i)
		}
	}
	return primes[2:]
}