// Dedicated to Junko F. Didi and Shree DR.MDD
module main

import strings

const digits = ['No', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine',
	'Ten']

fn craft_line(mut writer strings.Builder, count int, small bool) {
	if small {
		writer.write_rune(digits[count][0] | 32)
		writer.write_string(digits[count][1..])
	} else {
		writer.write_string(digits[count])
	}
	writer.write_string(' green bottle')
	if count != 1 {
		writer.write_rune(`s`)
	}
	writer.write_string(' hanging on the wall')
}

fn recite(start_bottles int, take_down int) string {
	mut writer := strings.new_builder(4000)
	mut current := start_bottles
	for current > start_bottles - take_down {
		craft_line(mut &writer, current, false)
		writer.write_string(',\n')

		craft_line(mut &writer, current, false)
		writer.write_string(',\n')

		writer.write_string("And if one green bottle should accidentally fall,\nThere'll be ")
		current--

		craft_line(mut &writer, current, true)
		writer.write_string('.\n\n')
	}
	writer.go_back(2)
	return writer.str()
}
