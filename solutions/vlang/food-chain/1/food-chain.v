// For Junko F. Didi and Shree DR.MDD
module main

import strings

const animals = ['', 'fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse']

const phrases = [
	'',
	"I don't know why she swallowed the fly. Perhaps she'll die.\n\n",
	'It wriggled and jiggled and tickled inside her.\n',
	'How absurd to swallow a bird!\n',
	'Imagine that, to swallow a cat!\n',
	'What a hog, to swallow a dog!\n',
	'Just opened her throat and swallowed a goat!\n',
	"I don't know how she swallowed a cow!\n",
	"She's dead, of course!\n\n",
]

fn recite(start_verse int, end_verse int) string {
	mut out := strings.new_builder(4096)
	for idx in start_verse .. end_verse + 1 {
		out.write_string('I know an old lady who swallowed a ')
		out.write_string(animals[idx])
		out.write_string('.\n')
		out.write_string(phrases[idx])

		if idx == 1 || idx == 8 {
			continue
		}

		mut k := idx
		for k > 1 {
			out.write_string('She swallowed the ')
			out.write_string(animals[k])
			out.write_string(' to catch the ')
			k--
			out.write_string(animals[k])
			if k == 2 {
				out.write_string(' that wriggled and jiggled and tickled inside her')
			}
			out.write_string('.\n')
		}
		out.write_string(phrases[1])
	}
	out.go_back(2)
	return out.str()
}
