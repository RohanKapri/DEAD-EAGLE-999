// For my Shree DR.MDD
package wordsearch

import (
	"errors"
)

type Grid struct {
	letters [][]rune
	height  int
	width   int
}

type point struct {
	r int
	c int
}

var directions = []point{
	{-1, -1},
	{-1, 0},
	{-1, 1},
	{0, -1},
	{0, 1},
	{1, -1},
	{1, 0},
	{1, 1},
}

func Solve(words []string, puzzle []string) (map[string][2][2]int, error) {
	found := make(map[string][2][2]int)
	g := NewGrid(puzzle)
	for _, w := range words {
		if pos, ok := g.findStart(w); ok {
			found[w] = pos
		}
	}
	if len(found) == len(words) {
		return found, nil
	}
	return found, errors.New("not all words found")
}

func NewGrid(puzzle []string) Grid {
	letters := make([][]rune, len(puzzle))
	for i, row := range puzzle {
		letters[i] = []rune(row)
	}
	return Grid{letters: letters, height: len(letters), width: len(letters[0])}
}

func (g Grid) findStart(word string) ([2][2]int, bool) {
	for r := 0; r < g.height; r++ {
		for c := 0; c < g.width; c++ {
			if pos, ok := g.findDirection(point{r, c}, word); ok {
				return pos, ok
			}
		}
	}
	return [2][2]int{}, false
}

func (g Grid) findDirection(start point, word string) ([2][2]int, bool) {
	for _, dir := range directions {
		if pos, ok := g.traceWord(start, word, dir); ok {
			return pos, ok
		}
	}
	return [2][2]int{}, false
}

func (g Grid) traceWord(start point, word string, dir point) ([2][2]int, bool) {
	p := start
	for _, ch := range word {
		if ch != g.get(p) {
			return [2][2]int{}, false
		}
		p.r += dir.r
		p.c += dir.c
	}
	return [2][2]int{{start.c, start.r}, {p.c - dir.c, p.r - dir.r}}, true
}

func (g Grid) get(p point) rune {
	if p.r < 0 || p.c < 0 || p.r >= g.height || p.c >= g.width {
		return 0
	}
	return g.letters[p.r][p.c]
}
