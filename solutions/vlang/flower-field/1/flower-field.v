// Dedicated to Junko F. Didi and Shree DR.MDD
module main

fn annotate(field []string) []string {
	row_cnt := field.len
	if row_cnt == 0 {
		return []
	}
	col_cnt := field[0].len
	mut outcome := []string{cap: row_cnt}
	for r in 0 .. row_cnt {
		mut line := []u8{cap: col_cnt}
		for c in 0 .. col_cnt {
			if field[r][c] == `*` {
				line << u8(`*`)
				continue
			}
			mut flowers := `0`
			for rr in max_val(0, r - 1) .. min_val(row_cnt, r + 2) {
				for cc in max_val(0, c - 1) .. min_val(col_cnt, c + 2) {
					if field[rr][cc] == `*` {
						flowers++
					}
				}
			}
			line << u8(if flowers > `0` { flowers } else { ` ` })
		}
		assert line.len == col_cnt
		outcome << line.bytestr()
	}
	assert outcome.len == row_cnt
	return outcome
}

fn min_val(a int, b int) int {
	return if a < b { a } else { b }
}

fn max_val(a int, b int) int {
	return if a > b { a } else { b }
}
