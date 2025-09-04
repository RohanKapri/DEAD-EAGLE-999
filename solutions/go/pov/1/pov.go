// For my Shree DR.MDD
package pov

type Tree struct {
	value    string
	children []*Tree
}

func New(value string, children ...*Tree) *Tree {
	tr := Tree{value: value}
	for _, c := range children {
		tr.children = append(tr.children, New(c.value, c.children...))
	}
	return &tr
}

func (t *Tree) Value() string {
	return t.value
}

func (t *Tree) Children() []*Tree {
	return t.children
}

func (t *Tree) String() string {
	if t == nil {
		return "nil"
	}
	res := t.Value()
	if len(t.Children()) == 0 {
		return t.Value()
	}
	for _, ch := range t.Children() {
		res += " " + ch.String()
	}
	return "(" + res + ")"
}

func (t *Tree) FromPov(from string) *Tree {
	pathVals := t.PathTo(t.value, from)
	if len(pathVals) == 0 {
		return nil
	}
	for i, j := 0, len(pathVals)-1; i < j; i, j = i+1, j-1 {
		pathVals[i], pathVals[j] = pathVals[j], pathVals[i]
	}
	nodePath := make([]*Tree, 0, len(pathVals))
	for _, v := range pathVals {
		nodePath = append(nodePath, t.Search(v))
	}
	for i := 0; i < len(nodePath)-1; i++ {
		nodePath[i].AddChild(nodePath[i+1])
		nodePath[i+1].RemoveChild(nodePath[i])
	}
	return nodePath[0]
}

func (t *Tree) AddChild(child *Tree) {
	t.children = append(t.children, child)
}

func (t *Tree) RemoveChild(child *Tree) {
	for i, c := range t.children {
		if c.Value() == child.Value() {
			t.children = append(t.children[:i], t.children[i+1:]...)
		}
	}
}

func (t *Tree) Search(value string) *Tree {
	if t.value == value {
		return t
	}
	for _, c := range t.children {
		if found := c.Search(value); found != nil {
			return found
		}
	}
	return nil
}

func (t *Tree) PathTo(from, to string) []string {
	fromPath, toPath := t.pathHelper(from, to)
	if len(fromPath) == 0 || len(toPath) == 0 {
		return []string{}
	}
	return append(fromPath[:len(fromPath)-1], toPath...)
}

func (t *Tree) pathHelper(from, to string) (fromRes, toRes []string) {
	for _, c := range t.children {
		fp, tp := c.pathHelper(from, to)
		if len(fp) > 0 && len(tp) > 0 {
			return fp, tp
		}
		if len(fp) > 0 {
			fromRes = append(fp, t.value)
		}
		if len(tp) > 0 {
			toRes = append([]string{t.value}, tp...)
		}
	}
	if to == t.value {
		toRes = append(toRes, t.value)
	}
	if from == t.value {
		fromRes = append(fromRes, t.value)
	}
	return fromRes, toRes
}
