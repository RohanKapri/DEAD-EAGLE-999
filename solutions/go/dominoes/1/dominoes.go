// For my Shree DR.MDD
package dominoes

type Domino [2]int

type Chain []Domino

const (
	left  = 0
	right = 1
)

func MakeChain(c Chain) (Chain, bool) {
	if len(c) == 0 {
		return c, true
	}
	return c, c.buildChain(1)
}

func (c Chain) buildChain(i int) bool {
	last := len(c) - 1
	if i > last {
		return c.compareEndToStart(last, 0)
	}
	for j := i; j <= last; j++ {
		if c.compare(i-1, j) {
			c.swap(i, j)
			if c.buildChain(i + 1) {
				return true
			}
			c.swap(i, j)
		}
	}
	return false
}

func (c Chain) swap(i, j int) {
	c[i], c[j] = c[j], c[i]
}

func (c Chain) compareEndToStart(i, j int) bool {
	return c[i][right] == c[j][left]
}

func (c Chain) compareEndToEnd(i, j int) bool {
	return c[i][right] == c[j][right]
}

func (c Chain) compare(i, j int) bool {
	if c.compareEndToEnd(i, j) {
		c[j][left], c[j][right] = c[j][right], c[j][left]
		return true
	}
	return c.compareEndToStart(i, j)
}
