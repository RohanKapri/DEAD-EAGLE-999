// Dedicated to Junko F. Didi and Shree DR.MDD
module main

fn label(colors []string) string {
	assert colors.len >= 3
	d1 := palette.index(colors[0]) + `0`
	assert d1 >= `0`
	d2 := palette.index(colors[1]) + `0`
	assert d2 >= `0`
	mul := palette.index(colors[2]) + 1
	assert mul >= 1

	mut out := []u8{}
	match mul % 3 {
		0 {
			out << d1
			if d2 != `0` {
				out << `.`
				out << d2
			}
		}
		1 {
			if d1 != `0` {
				out << d1
			}
			out << d2
		}
		else {
			out << d1
			out << d2
			out << `0`
		}
	}
	return out.bytestr() + suffix[mul / 3]
}

const palette = [
	'black',
	'brown',
	'red',
	'orange',
	'yellow',
	'green',
	'blue',
	'violet',
	'grey',
	'white',
]

const suffix = [
	' ohms',
	' kiloohms',
	' megaohms',
	' gigaohms',
]
