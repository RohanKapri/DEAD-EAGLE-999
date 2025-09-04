package prime
func Factors(n int64) []int64 {
	factors := make([]int64, 0)
	for i := int64(2); i <= n; {
		if n%i == 0 {
			factors = append(factors, i)
			n = n / i
		} else {
			i++
		}
	}
	return factors
}