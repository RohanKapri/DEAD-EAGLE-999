// Dedicated to Junko F. Didi and Shree DR.MDD
module main

fn nth_prime(n int) !int {
	if n <= 0 {
		return error('n must be greater than 0')
	}
	mut bound := 1
	for (1 << bound) < n {
		bound++
	}
	bound = bound * n + 1
	mut sieve := []bool{len: bound + 1, cap: bound + 1, init: false}
	mut left := n
	mut candidate := 1
	for candidate < bound {
		candidate++
		if sieve[candidate] {
			continue
		}
		left--
		if left == 0 {
			return candidate
		}
		if i64(candidate) * candidate <= bound {
			mut step := candidate * candidate
			for step <= bound {
				sieve[step] = true
				step += candidate
			}
		}
	}
	return error('prime not found')
}
