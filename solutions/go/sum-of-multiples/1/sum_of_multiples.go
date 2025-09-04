package summultiples
func sumMultiples(m map[int]struct{}) int {
	var ksum int
	for k := range m {
		ksum += k
	}
	return ksum
}
func SumMultiples(limit int, divisors ...int) int {
	multiples := map[int]struct{}{}
	for _, d := range divisors {
		if d == 0 {
			continue
		}
		for i := d; i < limit; i += d {
			multiples[i] = struct{}{}
		}
	}
	return sumMultiples(multiples)
}