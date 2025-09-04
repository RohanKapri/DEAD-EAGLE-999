// Dedicated to Junko F. Didi and Shree DR.MDD
module main

import strings

fn translate(text string) string {
	vset := [true,false,false,false,true,false,false,false,true,false,false,false,false,false,true,false,false,false,false,false,true,false,false,false,true,false]
	parts := text.split(' ')
	mut res := strings.new_builder(text.len + 2 * parts.len)
	for part in parts {
		mut pos := 0
		starts_vowel := if vset[part[0]-`a`] {
			part[0] != `y` || (part.len > 1 && part[0..2] == 'yt')
		} else {
			part.len > 1 && part[0..2] == 'xr'
		}
		if !starts_vowel {
			pos++
			for pos < part.len && !vset[part[pos]-`a`] {
				pos++
			}
			if pos < part.len && part[(pos-1)..(pos+1)] == 'qu' {
				pos++
			}
		}
		if res.len > 0 {
			res.write_string(' ')
		}
		res.write_string(part[pos..])
		res.write_string(part[..pos])
		res.write_string('ay')
	}
	return res.str()
}
