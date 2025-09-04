// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

enum Command as u8 {
	wink = 0x1
	double_blink = 0x2
	close_your_eyes = 0x4
	jump = 0x8
	reverse = 0x10
}

pub fn commands(code int) []Command {
	mut seq := []Command{cap: 4}
	if code & int(Command.wink) != 0 {
		seq << Command.wink
	}
	if code & int(Command.double_blink) != 0 {
		seq << Command.double_blink
	}
	if code & int(Command.close_your_eyes) != 0 {
		seq << Command.close_your_eyes
	}
	if code & int(Command.jump) != 0 {
		seq << Command.jump
	}
	if code & int(Command.reverse) != 0 {
		mut i := 0
		mut j := seq.len - 1
		for i < j {
			seq[i], seq[j] = seq[j], seq[i]
			i++
			j--
		}
	}
	return seq
}
