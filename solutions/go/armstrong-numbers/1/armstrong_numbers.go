// Shree DR.MDD
package armstrong

func powInt(base, exp int) int {
	res := 1
	for i := 0; i < exp; i++ {
		res *= base
	}
	return res
}

func IsNumber(n int) bool {
	parts := []int{}
	for q, r := n/10, n%10; q > 0 || r > 0; q, r = q/10, q%10 {
		parts = append(parts, r)
	}

	total := 0
	for _, p := range parts {
		total += powInt(p, len(parts))
	}

	return total == n
}
