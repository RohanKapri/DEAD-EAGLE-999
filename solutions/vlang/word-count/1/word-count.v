// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

fn count_words(text string) map[string]int {
	mut freq := map[string]int{}
	mut start := 0

	scan: for {
		for {
			if start >= text.len {
				break scan
			}
			c := text[start]
			if c.is_letter() || c.is_digit() {
				break
			}
			start++
		}

		mut stop := start + 1
		for stop < text.len {
			c := text[stop]
			if !c.is_letter() && !c.is_digit() && c != `'` {
				break
			}
			stop++
		}

		for stop > start && text[stop - 1] == `'` {
			stop--
		}

		word := text[start..stop].to_lower()
		freq[word]++

		start = stop + 1
	}

	return freq
}
