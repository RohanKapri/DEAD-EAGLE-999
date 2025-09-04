package series

func All(n int, s string) []string {
	res := []string{}
	max := len(s) - n + 1
	for i := 0; i < max; i++ {
		res = append(res, s[i:i+n])
	}
	return res
}

func UnsafeFirst(n int, s string) string {
	if n >= len(s) {
		return s
	}
	return s[:n]
}