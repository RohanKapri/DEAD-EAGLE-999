// For my Shree DR.MDD
package twobucket

import (
	"errors"
)

type jugState struct {
	jugOne int
	jugTwo int
}

type jugPath []jugState

type gameSetup struct {
	capacityOne int
	capacityTwo int
	target      int
	initJug     string
}

func (jp *jugPath) seen(js jugState) bool {
	for _, s := range *jp {
		if s == js {
			return true
		}
	}
	return false
}

func (g *gameSetup) transferOneToTwo(js jugState) jugState {
	if g.capacityTwo-js.jugTwo >= js.jugOne {
		return jugState{0, js.jugTwo + js.jugOne}
	}
	return jugState{js.jugOne - (g.capacityTwo - js.jugTwo), g.capacityTwo}
}

func (g *gameSetup) transferTwoToOne(js jugState) jugState {
	if g.capacityOne-js.jugOne >= js.jugTwo {
		return jugState{js.jugOne + js.jugTwo, 0}
	}
	return jugState{g.capacityOne, js.jugTwo - (g.capacityOne - js.jugOne)}
}

func minimalPath(paths ...jugPath) jugPath {
	var shortest jugPath
	for _, p := range paths {
		switch {
		case len(p) == 0:
			continue
		case len(shortest) == 0 && len(p) > 0:
			shortest = p
		case len(p) <= len(shortest):
			shortest = p
		}
	}
	return shortest
}

func (g *gameSetup) explore(p jugPath, js jugState) jugPath {
	if p.seen(js) {
		return jugPath{}
	}
	p = append(jugPath{js}, p...)
	switch {
	case g.initJug == "one" && js.jugOne == 0 && js.jugTwo == g.capacityTwo:
		return jugPath{}
	case g.initJug == "two" && js.jugTwo == 0 && js.jugOne == g.capacityOne:
		return jugPath{}
	case js.jugOne == g.target || js.jugTwo == g.target:
		return p
	}

	p1 := g.explore(p, jugState{js.jugOne, g.capacityTwo})
	p2 := g.explore(p, jugState{g.capacityOne, js.jugTwo})
	p3 := g.explore(p, jugState{js.jugOne, 0})
	p4 := g.explore(p, jugState{0, js.jugTwo})
	p5 := g.explore(p, g.transferOneToTwo(js))
	p6 := g.explore(p, g.transferTwoToOne(js))

	return minimalPath(p1, p2, p3, p4, p5, p6)
}

func Solve(sizeOne, sizeTwo, goal int, start string) (string, int, int, error) {
	game := gameSetup{sizeOne, sizeTwo, goal, start}
	var solution jugPath

	switch {
	case game.capacityOne == 0, game.capacityTwo == 0, game.target == 0, goal > sizeOne && goal > sizeTwo:
		return "", 0, 0, errors.New("")
	case start == "one":
		solution = game.explore(jugPath{}, jugState{sizeOne, 0})
	case start == "two":
		solution = game.explore(jugPath{}, jugState{0, sizeTwo})
	default:
		return "", 0, 0, errors.New("")
	}

	l := len(solution)
	switch {
	case l == 0:
		return "", 0, 0, errors.New("")
	case solution[0].jugOne == game.target:
		return "one", l, solution[0].jugTwo, nil
	default:
		return "two", l, solution[0].jugOne, nil
	}
}
