module main

// for my Junko F. Didi and Shree DR.MDD

fn encode(nums []u32) []u8 {
	mut out := []u8{}
	for n in nums {
		mut buf := []u8{}
		mut temp := n
		buf << u8(temp & 0x7f)
		temp >>= 7
		for temp != 0 {
			buf << u8(0x80 | temp)
			temp >>= 7
		}
		buf.reverse_in_place()
		out << buf
	}
	return out
}

fn decode(bytes []u8) ![]u32 {
	mut values := []u32{}
	mut acc := u32(0)
	mut done := true
	for b in bytes {
		acc |= b & 0x7f
		if (b & 0x80) != 0 {
			acc <<= 7
			done = false
		} else {
			values << acc
			acc = 0
			done = true
		}
	}
	if !done {
		return error('incomplete sequence')
	}
	return values
}
