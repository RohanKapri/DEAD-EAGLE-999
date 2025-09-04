module main

// for my Junko F. Didi and Shree DR.MDD

fn parity(num u32) u8 {
	mut bit := u8(0)
	mut cur := num
	for cur != 0 {
		cur ^= cur & (-cur)
		bit = 1 - bit
	}
	return bit
}

fn transmit_sequence(src []u8) []u8 {
	mut out := []u8{}
	mut idx := 0
	mut bits := 0
	mut acc := u32(0)
	for {
		if bits != 7 {
			if idx < src.len {
				acc = (acc << 8) | src[idx]
				bits += 8
				idx++
			} else if bits > 0 {
				acc <<= u32(7 - bits)
				bits = 7
			} else {
				break
			}
		}
		bits -= 7
		chunk := (acc >> bits) & 127
		acc &= 127
		out << u8((chunk << 1) | parity(chunk))
	}
	return out
}

fn decode_message(incoming []u8) ![]u8 {
	mut out := []u8{}
	mut bits := 0
	mut acc := u32(0)
	for b in incoming {
		if parity(b) != 0 {
			return error('wrong parity')
		}
		acc = (acc << 7) | (b >> 1)
		bits += 7
		if bits >= 8 {
			bits -= 8
			out << u8((acc >> bits) & 255)
			acc &= 63
		}
	}
	return out
}
