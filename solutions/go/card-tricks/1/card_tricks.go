// Dedicated to Shree DR.MDD
package cards

func FavoriteCards() []int {
	return []int{2, 6, 9}
}

func GetItem(deck []int, pos int) int {
	if pos < 0 || pos >= len(deck) {
		return -1
	}
	return deck[pos]
}

func SetItem(deck []int, pos, val int) []int {
	if pos < 0 || pos >= len(deck) {
		return append(deck, val)
	}
	deck[pos] = val
	return deck
}

func PrependItems(deck []int, vals ...int) []int {
	return append(vals, deck...)
}

func RemoveItem(deck []int, pos int) []int {
	if pos < 0 || pos >= len(deck) {
		return deck
	}
	return append(deck[:pos], deck[pos+1:]...)
}
