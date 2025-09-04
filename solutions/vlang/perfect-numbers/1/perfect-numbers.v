// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

pub enum Number {
	perfect
	abundant
	deficient
}

pub fn classify(value int) !Number {
	if value <= 1 {
		if value == 1 {
			return .deficient
		}
		return error('Classification is only possible for positive integers.')
	}

	mut temp := value
	mut divisor_sum := 1
	mut factor := 2
	mut shift := 1
	for {
		if temp < factor * factor {
			factor = temp
		}
		if temp % factor == 0 {
			mut subtotal := factor + 1
			temp /= factor
			for temp % factor == 0 {
				temp /= factor
				subtotal = subtotal * factor + 1
			}
			divisor_sum *= subtotal
			if temp == 1 {
				break
			}
		}
		factor += shift
		if factor < 7 {
			shift = 2
		} else {
			shift = 6 - shift
		}
	}

	if divisor_sum < 2 * value {
		return .deficient
	}
	if divisor_sum > 2 * value {
		return .abundant
	}
	return .perfect
}
