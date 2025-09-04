// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

fn encode(text string) string {
	mut buf := []u8{len: text.len}
	mut pos := text.len
	mut right := text.len

	for right > 0 {
		ch := text[right - 1]
		mut left := right - 1
		for left > 0 && text[left - 1] == ch {
			left--
		}
		pos--
		buf[pos] = ch
		mut cnt := right - left
		if cnt > 1 {
			for cnt > 0 {
				pos--
				buf[pos] = u8(`0` + (cnt % 10))
				cnt /= 10
			}
		}
		right = left
	}
	return buf[pos..text.len].bytestr()
}

fn decode(text string) string {
	mut buf := []u8{}
	mut cnt := 0
	for ch in text {
		if ch.is_digit() {
			cnt = cnt * 10 + int(ch - `0`)
		} else {
			if cnt == 0 {
				buf << ch
			} else {
				for cnt > 0 {
					buf << ch
					cnt--
				}
			}
			cnt = 0
		}
	}
	return buf.bytestr()
}
