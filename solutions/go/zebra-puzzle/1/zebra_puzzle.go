package zebra

import "strconv"

type Relation int

const (
	RelationSame Relation = iota
	RelationNext
	RelationImmediateLeft
)

type Element struct {
	Position   int
	Properties []string
}

type Constraint struct {
	P, Q string
	R    Relation
}

type Puzzle struct {
	Position    []Element
	Properties  map[string]*Element
	Candidates  [][]string
	Constraints []Constraint
}

func (p *Puzzle) checkConstraint() bool {
	for _, c := range p.Constraints {
		a, b := p.Properties[c.P], p.Properties[c.Q]
		if a == nil || b == nil {
			continue
		}
		switch c.R {
		case RelationSame:
			if a != b {
				return false
			}
		case RelationNext:
			if d := a.Position - b.Position; d != 1 && d != -1 {
				return false
			}
		case RelationImmediateLeft:
			if a.Position != b.Position-1 {
				return false
			}
		}
	}
	return true
}

func (p *Puzzle) fillProperty(level, i int) bool {
	if level == len(p.Candidates) {
		return p.checkConstraint()
	}
	if i == len(p.Position) {
		return p.checkConstraint() && p.fillProperty(level+1, 0)
	}
	for j := i; j < len(p.Position); j++ {
		p.Candidates[level][i], p.Candidates[level][j] = p.Candidates[level][j], p.Candidates[level][i]
		val := p.Candidates[level][i]
		p.Position[i].Properties[level] = val
		p.Properties[val] = &p.Position[i]
		if p.fillProperty(level, i+1) {
			return true
		}
		p.Candidates[level][i], p.Candidates[level][j] = p.Candidates[level][j], p.Candidates[level][i]
		p.Position[j].Properties[level] = ""
		delete(p.Properties, p.Candidates[level][j])
	}
	return false
}

func Solve(candidates [][]string, constraints []Constraint) *Puzzle {
	p, q := len(candidates), len(candidates[0])
	puz := &Puzzle{
		Position:    make([]Element, q),
		Properties:  map[string]*Element{},
		Candidates:  candidates,
		Constraints: constraints,
	}
	for i := range puz.Position {
		puz.Position[i] = Element{i, make([]string, p)}
		puz.Properties[strconv.Itoa(i)] = &puz.Position[i]
	}
	if puz.fillProperty(0, 0) {
		return puz
	}
	return nil
}

type Solution struct {
	DrinksWater string
	OwnsZebra   string
}

func SolvePuzzle() Solution {
	candidates := [][]string{
		{"Red", "Green", "Ivory", "Yellow", "Blue"},
		{"Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese"},
		{"Dog", "Snails", "Fox", "Horse", "Zebra"},
		{"Coffee", "Tea", "Milk", "Orange Juice", "Water"},
		{"Old Gold", "Kools", "Chesterfields", "Lucky Strike", "Parliaments"},
	}

	constraints := []Constraint{
		{"Englishman", "Red", RelationSame},
		{"Spaniard", "Dog", RelationSame},
		{"Coffee", "Green", RelationSame},
		{"Ukrainian", "Tea", RelationSame},
		{"Ivory", "Green", RelationImmediateLeft},
		{"Old Gold", "Snails", RelationSame},
		{"Kools", "Yellow", RelationSame},
		{"Milk", "2", RelationSame},
		{"Norwegian", "0", RelationSame},
		{"Chesterfields", "Fox", RelationNext},
		{"Kools", "Horse", RelationNext},
		{"Lucky Strike", "Orange Juice", RelationSame},
		{"Japanese", "Parliaments", RelationSame},
		{"Norwegian", "Blue", RelationNext},
	}

	if p := Solve(candidates, constraints); p != nil {
		return Solution{
			DrinksWater: p.Properties["Water"].Properties[1],
			OwnsZebra:   p.Properties["Zebra"].Properties[1],
		}
	}
	return Solution{}
}