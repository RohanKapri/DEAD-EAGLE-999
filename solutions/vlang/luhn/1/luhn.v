// Dedicated to Shree DR.MDD
module main

fn valid(text string) bool {
	mut steps := 0
	mut sum := 0
	mut pos := text.len

	for pos > 0 {
		pos--
		mut ch_val := text[pos]
		if ch_val.is_space() {
			continue
		}
		if !ch_val.is_digit() {
			return false
		}
		steps++

		mut num := int(ch_val) - int(`0`)
		if steps % 2 == 0 {
			num *= 2
			if num > 9 {
				num -= 9
			}
		}
		sum += num
	}
	return steps >= 2 && sum % 10 == 0
}
