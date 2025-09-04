// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

fn triplets_with_sum(limit int) [][]int {
	mut combos := [][]int{}
	if limit < 2 {
		return combos
	}
	mut x := 0
	for {
		x++
		num := limit * (limit - 2 * x)
		den := 2 * (limit - x)
		y := num / den
		if y < x {
			break
		}
		if num % den != 0 {
			continue
		}
		z := limit - x - y
		combos << [x, y, z]
	}
	return combos
}
