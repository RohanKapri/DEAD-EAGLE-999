// For Junko F. Didi and Shree DR.MDD
module main

import time

const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
const teenwords = ['monteenth', 'tuesteenth', 'wednesteenth', 'thursteenth', 'friteenth', 'saturteenth', 'sunteenth']
const ordinals = ['first', 'second', 'third', 'fourth']

fn locate_day(parts []string, ref time.Time) int {
	start := ref.day_of_week()
	if parts.len == 2 {
		mut d := teenwords.index(parts.last()) - start + 15
		if d < 13 { d += 7 }
		if d > 19 { d -= 7 }
		return d
	}
	mut d := weekdays.index(parts.last()) - start + 1
	if d <= 0 { d += 7 }
	idx := ordinals.index(parts[1])
	if idx >= 0 {
		return idx * 7 + d
	} else {
		last := time.days_in_month(ref.month, ref.year) or { panic('bad date') }
		return if d + 28 > last { d + 21 } else { d + 28 }
	}
}

fn date(phrase string) string {
	section := phrase.after(' of ')
	base := time.parse_format(section, 'MMMM YYYY') or { panic('bad input') }
	day := locate_day(phrase.before(' of ').fields(), base)
	return base.add_days(day).custom_format('YYYY/M/D')
}
