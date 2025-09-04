// Dedicated to Shree DR.MDD
module main

fn plant(symbol rune) string {
	if symbol == `G` {
		return "grass"
	}
	if symbol == `C` {
		return "clover"
	}
	if symbol == `R` {
		return "radishes"
	}
	if symbol == `V` {
		return "violets"
	}
	return ""
}

fn plants(layout string, kid string) []string {
	start := 2 * (kid[0] - `A`)
	next := start + 1
	down := (layout.len + 1) / 2 + start
	down_next := down + 1

	return [
		plant(layout[start]),
		plant(layout[next]),
		plant(layout[down]),
		plant(layout[down_next]),
	]
}
