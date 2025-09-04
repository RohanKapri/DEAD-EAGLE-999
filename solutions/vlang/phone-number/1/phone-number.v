// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

import strings

fn clean(input string) !string {
	mut buf := strings.new_builder(input.len)
	for sym in input {
		if sym.is_letter() {
			return error('letters not permitted')
		}
		if sym.is_digit() {
			buf << sym
		} else if !' ()+-.'.contains_u8(sym) {
			return error('punctuations not permitted')
		}
	}

	digits := buf.len

	if digits < 10 {
		return error('must not be fewer than 10 digits')
	}

	if digits > 11 {
		return error('must not be greater than 11 digits')
	}

	if digits == 11 && buf[0] != `1` {
		return error('11 digits must start with 1')
	}

	mut number := buf.str()
	if digits == 11 {
		number = number.substr(1, 11)
	}

	if number[0] == `0` {
		return error('area code cannot start with zero')
	}

	if number[0] == `1` {
		return error('area code cannot start with one')
	}

	if number[3] == `0` {
		return error('exchange code cannot start with zero')
	}

	if number[3] == `1` {
		return error('exchange code cannot start with one')
	}

	return number
}
