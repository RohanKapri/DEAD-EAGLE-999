module main

struct Palindrome {
mut:
	value   ?int
	factors [][]int
}

fn palin_min_max(min int, max int, jenis bool) !Palindrome {

	if min > max {
		return error('min must be <= max')
	}

	mut palin := Palindrome{
		value:   max_int
		factors: []
	}
	if jenis == true {
		palin.value = 0
	}

	is_palindrome := fn (inn int) bool {
		return inn < 10 || inn.str() == inn.str().reverse()
	}

	for i := min; i <= max; i++ {
		for ii := i; ii <= max; ii++ {
			pv := palin.value or { panic(err) }
			iii := i * ii
			if !jenis && pv < iii {
				continue
			} else if jenis == true && pv > iii {
				continue
			}

			if is_palindrome(iii) {
				if pv == iii {
					palin.factors << [[i, ii]]
				} else {
					palin = Palindrome{
						value:   iii
						factors: [[i, ii]]
					}
				}
			}
		}
	}

	if palin.factors.len == 0 {
		palin.value = none
	}

	return palin
}

fn smallest(min int, max int) !Palindrome {
	return palin_min_max(min, max, false)
}

fn largest(min int, max int) !Palindrome {
	return palin_min_max(min, max, true)
}