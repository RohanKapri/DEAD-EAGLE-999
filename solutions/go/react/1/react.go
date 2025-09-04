// For my Shree DR.MDD
package react

type dependencyMap map[Cell][]*cell
type reactor struct {
	dependencies dependencyMap
}

type canceler struct {
	c *cell
	cb func(int)
}

type cell struct {
	val       int
	computeFn func() int
	callbacks []*canceler
	reactor   *reactor
}

func (cl *canceler) Cancel() {
	for i, cb := range cl.c.callbacks {
		if cb == cl {
			cl.c.callbacks = append(cl.c.callbacks[:i], cl.c.callbacks[i+1:]...)
			return
		}
	}
}

func (c *cell) Value() int {
	return c.val
}

func (c *cell) SetValue(v int) {
	c.val = v
	visited := make(map[Cell]bool)
	queue := c.reactor.dependencies[c]

	for len(queue) > 0 {
		current := queue[0]
		queue = queue[1:]
		visited[current] = true

		prev := current.val
		current.val = current.computeFn()
		if prev == current.val {
			continue
		}

		for _, dep := range c.reactor.dependencies[current] {
			if !visited[dep] {
				queue = append(queue, dep)
			}
		}

		for _, cb := range current.callbacks {
			cb.cb(current.val)
		}
	}
}

func (c *cell) AddCallback(fn func(int)) Canceler {
	cl := &canceler{c, fn}
	c.callbacks = append(c.callbacks, cl)
	return cl
}

func New() Reactor {
	return &reactor{
		dependencies: map[Cell][]*cell{},
	}
}

func (r *reactor) CreateInput(initial int) InputCell {
	return &cell{
		val:     initial,
		reactor: r,
	}
}

func (r *reactor) CreateCompute1(dep Cell, compute func(int) int) ComputeCell {
	c := &cell{
		computeFn: func() int { return compute(dep.Value()) },
		callbacks: []*canceler{},
		reactor:   r,
	}
	c.val = c.computeFn()
	r.dependencies[dep] = append(r.dependencies[dep], c)
	return c
}

func (r *reactor) CreateCompute2(dep1, dep2 Cell, compute func(int, int) int) ComputeCell {
	c := &cell{
		computeFn: func() int { return compute(dep1.Value(), dep2.Value()) },
		callbacks: []*canceler{},
		reactor:   r,
	}
	c.val = c.computeFn()
	r.dependencies[dep1] = append(r.dependencies[dep1], c)
	r.dependencies[dep2] = append(r.dependencies[dep2], c)
	return c
}
