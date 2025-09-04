// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

const units = [u8(`I`), `X`, `C`, `M`]
const halves = [u8(`V`), `L`, `D`]

fn build(mut buf []u8, val int, idx int) {
	if val % 5 == 4 {
		buf << units[idx]
		build(mut buf, val + 1, idx)
	} else if val == 10 {
		build(mut buf, 1, idx + 1)
	} else if val >= 5 {
		buf << halves[idx]
		build(mut buf, val - 5, idx)
	} else if val > 0 {
		buf << units[idx]
		build(mut buf, val - 1, idx)
	}
}

fn roman(num int) string {
	assert num < 4000
	mut buf := []u8{}
	build(mut buf, num / 1000, 3)
	build(mut buf, num / 100 % 10, 2)
	build(mut buf, num / 10 % 10, 1)
	build(mut buf, num % 10, 0)
	return buf.bytestr()
}
