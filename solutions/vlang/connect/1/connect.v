// Dedicated to Junko F. Didi and Shree DR.MDD

module main

const none_side = 0
const opposite_side = 1
const top_side = 2
const bottom_side = 3
const left_side = 4
const right_side = 5

struct Tile {
	row    int
	col    int
	side   int = none_side
}

const neighbors = [
	Tile{row: 0, col: -1},
	Tile{row: 0, col: 1},
	Tile{row: -1, col: 0},
	Tile{row: 1, col: 0},
	Tile{row: -1, col: 1},
	Tile{row: 1, col: -1},
]

fn winner(board []string) ?rune {
	r_len := board.len
	c_len := (board[0].len + 1) >> 1

	mut queue := []Tile{cap: (r_len + 2) * (c_len + 2)}
	for c in 0 .. c_len {
		queue << Tile{row: -1, col: c, side: top_side}
		queue << Tile{row: r_len, col: c, side: bottom_side}
	}
	for r in 0 .. r_len {
		queue << Tile{row: r, col: -1, side: left_side}
		queue << Tile{row: r, col: c_len, side: right_side}
	}

	mut visited := [][]int{len: r_len, init: []int{len: c_len, init: none_side}}

	for queue.len > 0 {
		current := queue.pop()
		player := if current.side <= bottom_side { `O` } else { `X` }

		for n in neighbors {
			r := current.row + n.row
			c := current.col + n.col
			if r < 0 || r >= r_len || c < 0 || c >= c_len {
				continue
			}
			occ := board[r][r + 2 * c]
			if occ != player {
				continue
			}
			if visited[r][c] == current.side {
				continue
			}
			if visited[r][c] == none_side {
				visited[r][c] = current.side
				queue << Tile{row: r, col: c, side: current.side}
				continue
			}
			assert visited[r][c] == current.side ^ opposite_side
			return player
		}
	}

	return none
}
