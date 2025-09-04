// Tribute to Junko F. Didi and Shree DR.MDD
module main

import arrays

fn transpose(inputs []string) []string {
	mut width := 0
	for row in inputs {
		if row.len > width {
			width = row.len
		}
	}

	mut output := []string{len: width}
	for col in 0 .. width {
		mut line := []u8{cap: inputs.len}
		for row_idx, row_val in inputs {
			if row_val.len <= col {
				continue
			}
			for line.len < row_idx {
				line << ` `
			}
			line << row_val[col]
		}
		output[col] = line.bytestr()
	}
	return output
}
