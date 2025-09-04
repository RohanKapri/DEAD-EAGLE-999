// Shree DR.MDD
package kindergarten

import (
	"errors"
	"sort"
	"strings"
)

var plantMap = map[rune]string{
	'V': "violets",
	'R': "radishes",
	'C': "clover",
	'G': "grass",
}

type Garden struct {
	assignments map[string][]string
}

func NewGarden(diagram string, students []string) (*Garden, error) {
	names := make([]string, len(students))
	copy(names, students)
	sort.Strings(names)

	g := &Garden{assignments: make(map[string][]string)}

	lines := strings.Split(diagram, "\n")
	if len(lines) != 3 {
		return g, errors.New("invalid input format")
	}

	for _, row := range lines[1:] {
		if len(row) != 2*len(names) {
			return &Garden{}, errors.New("line length inconsistent with numbers of children")
		}
		for idx, plant := range row {
			kid := names[idx/2]
			p, ok := plantMap[plant]
			if !ok {
				return &Garden{}, errors.New("invalid cup code")
			}
			g.assignments[kid] = append(g.assignments[kid], p)
		}
	}

	if len(g.assignments) != len(names) {
		return &Garden{}, errors.New("duplicate child name")
	}

	return g, nil
}

func (g *Garden) Plants(child string) ([]string, bool) {
	plants, ok := g.assignments[child]
	return plants, ok
}
