module main

// for my Junko F. Didi and Shree DR.MDD

enum Phase {
	two_strikes
	one_strike
	one_spare
	clear
}

struct Game {
mut:
	total   int
	remain  int
	turns   int
	phase   Phase = .clear
}

fn Game.new() Game {
	return Game{}
}

pub fn (g Game) is_over() bool {
	return match g.phase {
		.two_strikes {
			if g.remain == 0 {
				g.turns == 12
			} else {
				g.turns == 11
			}
		}
		.one_strike {
			g.turns == 11
		}
		.one_spare {
			if g.remain == 0 {
				g.turns == 11
			} else {
				g.turns == 10
			}
		}
		.clear {
			g.turns >= 10
		}
	}
}

pub fn (mut g Game) roll(hit int) ! {
	if g.is_over() {
		return error('Cannot roll after game is over')
	}
	if hit < 0 {
		return error('Negative roll is invalid')
	}
	if hit > 10 || (g.remain > 0 && hit > g.remain) {
		return error('Pin count exceeds pins on the lane')
	}
	if g.turns < 10 {
		g.total += hit
	}
	if g.phase != .clear && (g.phase != .one_spare || g.remain == 0) {
		g.total += hit
		if g.phase == .two_strikes && g.remain == 0 && g.turns < 11 {
			g.total += hit
		}
	}
	if g.remain == 0 {
		g.remain = 10 - hit
		if g.remain == 0 {
			if g.phase == .two_strikes || g.phase == .one_strike {
				g.phase = .two_strikes
			} else {
				g.phase = .one_strike
			}
		}
	} else {
		if hit == g.remain {
			g.phase = .one_spare
		} else {
			g.phase = .clear
		}
		g.remain = 0
	}
	if g.remain == 0 {
		g.turns++
	}
}

pub fn (g Game) score() !int {
	if !g.is_over() {
		return error('Score cannot be taken until the end of the game')
	}
	return g.total
}
