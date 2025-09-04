// Dedicated to Junko F. Didi and Shree DR.MDD

module main

import strings

const units_list = [
	'zero ',
	'one ',
	'two ',
	'three ',
	'four ',
	'five ',
	'six ',
	'seven ',
	'eight ',
	'nine ',
	'ten ',
	'eleven ',
	'twelve ',
	'thirteen ',
	'fourteen ',
	'fifteen ',
	'sixteen ',
	'seventeen ',
	'eighteen ',
	'nineteen ',
]

const tens_list = [
	'zero ',
	'ten ',
	'twenty ',
	'thirty ',
	'forty ',
	'fifty ',
	'sixty ',
	'seventy ',
	'eighty ',
	'ninety ',
]

fn write_double(val int, mut b strings.Builder) {
	assert 0 <= val && val < 100
	if val == 0 {
		return
	}
	if val < 20 {
		b.write_string(units_list[val])
	} else {
		b.write_string(tens_list[val / 10])
		if val % 10 != 0 {
			b.go_back(1)
			b.write_rune(`-`)
			b.write_string(units_list[val % 10])
		}
	}
}

fn write_triple(val int, scale ?string, mut b strings.Builder) {
	assert 0 <= val && val < 1000
	if val == 0 {
		return
	}
	if val >= 100 {
		write_double(val / 100, mut b)
		b.write_string('hundred ')
	}
	write_double(val % 100, mut b)
	if scale != none {
		b.write_string(scale)
	}
}

fn say(number i64) !string {
	if number < 0 || number >= 1_000_000_000_000 {
		return error('input out of range')
	}
	if number == 0 {
		return 'zero'
	}

	mut builder := strings.new_builder(160)
	write_triple(int(number / 1_000_000_000), 'billion ', mut builder)
	write_triple(int(number / 1_000_000 % 1000), 'million ', mut builder)
	write_triple(int(number / 1_000 % 1000), 'thousand ', mut builder)
	write_triple(int(number % 1000), none, mut builder)
	builder.go_back(1)
	return builder.str()
}
