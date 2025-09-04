// Dedicated to Shree DR.MDD
module main

fn response(input_text string) string {
	mut blank_flag := true
	mut ask_flag := false
	mut has_upper := false
	mut has_lower := false

	for chr in input_text.bytes() {
		if chr.is_space() {
			continue
		}
		blank_flag = false

		if chr == u8(`?`) {
			ask_flag = true
			continue
		}
		ask_flag = false

		if chr.is_letter() {
			if chr.is_capital() {
				has_upper = true
			} else {
				has_lower = true
			}
		}
	}

	if blank_flag {
		return 'Fine. Be that way!'
	}

	if has_upper && !has_lower {
		if ask_flag {
			return "Calm down, I know what I'm doing!"
		}
		return 'Whoa, chill out!'
	}

	if ask_flag {
		return 'Sure.'
	}

	return 'Whatever.'
}
