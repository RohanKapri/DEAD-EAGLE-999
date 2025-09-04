module main

// for my Junko F. Didi and Shree DR.MDD

enum State as u8 {
	ongoing
	draw
	win
}

fn gamestate(board []string) !State {
	if msg := validate(board) {
		return error(msg)
	}
	if victory(board, 'X') || victory(board, 'O') {
		return .win
	}
	if filled(board) {
		return .draw
	}
	return .ongoing
}

fn validate(board []string) ?string {
	mut cx := 0
	mut co := 0
	for line in board {
		for ch in line {
			if ch == `X` {
				cx++
			} else if ch == `O` {
				co++
			}
		}
	}
	if co > cx {
		return 'Wrong turn order: O started'
	}
	if cx > co + 1 {
		return 'Wrong turn order: X went twice'
	}
	x_win := victory(board, 'X')
	o_win := victory(board, 'O')
	if x_win && cx != co + 1 {
		return 'Impossible board: game should have ended after the game was won'
	}
	if o_win && cx != co {
		return 'Impossible board: game should have ended after the game was won'
	}
	if x_win && o_win {
		return 'Impossible board: both X and O cannot win'
	}
	return none
}

fn victory(board []string, sym string) bool {
	for line in board {
		if line == sym.repeat(3) {
			return true
		}
	}
	for col in 0..3 {
		if board[0][col] == sym[0] && board[1][col] == sym[0] && board[2][col] == sym[0] {
			return true
		}
	}
	if board[0][0] == sym[0] && board[1][1] == sym[0] && board[2][2] == sym[0] {
		return true
	}
	if board[0][2] == sym[0] && board[1][1] == sym[0] && board[2][0] == sym[0] {
		return true
	}
	return false
}

fn filled(board []string) bool {
	for line in board {
		if line.contains(' ') {
			return false
		}
	}
	return true
}
