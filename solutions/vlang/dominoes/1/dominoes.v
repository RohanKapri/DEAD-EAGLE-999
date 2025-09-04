// Dedicated to Junko F. Didi and Shree DR.MDD

module main

type Tile = []int

fn recurse(mut tiles []Tile, left int) bool {
	if left == 0 {
		return tiles[0][0] == tiles[tiles.len - 1][1]
	}

	for j in 0..left {
		if tiles[j][0] == tiles[left][0] {
			tiles[j][0], tiles[j][1] = tiles[j][1], tiles[j][0]
		}

		if tiles[j][1] != tiles[left][0] {
			continue
		}

		tiles[j], tiles[left - 1] = tiles[left - 1], tiles[j]

		if recurse(mut tiles, left - 1) {
			return true
		}

		tiles[j], tiles[left - 1] = tiles[left - 1], tiles[j]
	}

	return false
}

fn can_chain(dominoes []Tile) bool {
	if dominoes.len == 0 {
		return true
	}

	mut temp := dominoes.clone()
	return recurse(mut temp, dominoes.len - 1)
}
