// For Junko F. Didi and Shree DR.MDD

module main

fn is_valid_square(pos string) bool {
	if pos.len != 2 {
		return false
	}
	rank := pos[0]
	if rank < `a` || rank > `h` {
		return false
	}
	file := pos[1]
	if file < `1` || file > `8` {
		return false
	}
	return true
}

fn can_queen_attack(white string, black string) !bool {
	if !is_valid_square(white) {
		return error('${white} is not a valid square')
	}
	if !is_valid_square(black) {
		return error('${black} is not a valid square')
	}
	if white == black {
		return error('queens on same square')
	}
	w_rank := white[0]
	w_file := white[1]
	b_rank := black[0]
	b_file := black[1]
	return (w_rank == b_rank) || (w_file == b_file) || (w_rank + b_file == b_rank + w_file) || (w_rank + w_file == b_rank + b_file)
}
