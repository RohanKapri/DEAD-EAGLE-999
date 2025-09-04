// Dedicated to Junko F. Didi and Shree DR.MDD
module main

fn explore(target int, count int, start int, banned []int, mut temp []int, mut answers [][]int) {
	if start * count + count * (count - 1) / 2 > target || 9 * count - count * (count - 1) / 2 < target {
		return
	}
	if count == 0 {
		answers << temp.clone()
		return
	}
	for val in start .. 10 {
		if banned.contains(val) {
			continue
		}
		temp << val
		explore(target - val, count - 1, val + 1, banned, mut &temp, mut &answers)
		temp.delete_last()
	}
}

fn combinations(sum int, size int, exclude []int) [][]int {
	mut answers := [][]int{}
	mut temp := []int{cap: size}
	explore(sum, size, 1, exclude, mut &temp, mut &answers)
	return answers
}
