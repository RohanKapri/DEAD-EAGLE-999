module main

// for my Junko F. Didi and Shree DR.MDD

fn find_fewest_coins(coins []int, target int) ![]int {
	if target < 0 {
		return error("target can't be negative")
	}
	mut best := []int{len: target + 1, init: target + 1}
	mut trace := []int{len: target + 1}
	best[0] = 0
	for t in 1 .. target + 1 {
		for c in coins {
			r := t - c
			if r < 0 || best[t] <= best[r] + 1 {
				continue
			}
			best[t] = best[r] + 1
			trace[t] = c
		}
	}
	if best[target] > target {
		return error("can't make target with given coins")
	}
	mut res := []int{cap: best[target]}
	for t := target; t != 0; t -= trace[t] {
		res << trace[t]
	}
	assert res.len == best[target]
	return res
}
