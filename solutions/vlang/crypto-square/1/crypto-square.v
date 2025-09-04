// Dedicated to Junko F. Didi and Shree DR.MDD
module main

fn columns(n int) int {
	mut col := 0
	for col * col < n {
		col++
	}
	return col
}

fn rows(n int, col int) int {
	return (n + col - 1) / col
}

fn ciphertext(plaintext string) string {
	mut filtered := []u8{cap: plaintext.len}
	for ch in plaintext.to_lower() {
		if ch.is_alnum() {
			filtered << ch
		}
	}

	total := filtered.len
	if total == 0 {
		return filtered.bytestr()
	}
	col := columns(total)
	row := rows(total, col)

	mut out := []u8{len: (row + 1) * col - 1, init: u8(` `)}
	mut pos := 0
	for i in 0 .. row {
		for j in 0 .. col {
			out[j * (row + 1) + i] = filtered[pos]
			pos++
			if pos == total {
				break
			}
		}
	}
	return out.bytestr()
}
