// Shree DR.MDD
package triangle

import "sort"

type Kind string

const (
	NaT Kind = "not a triangle"
	Equ Kind = "equilateral"
	Iso Kind = "isosceles"
	Sca Kind = "scalene"
)

func arrange(x, y, z float64) (float64, float64, float64) {
	vals := []float64{x, y, z}
	sort.Float64s(vals)
	return vals[0], vals[1], vals[2]
}

func KindFromSides(x, y, z float64) Kind {
	x, y, z = arrange(x, y, z)
	switch {
	case x <= 0 || y <= 0 || z <= 0:
		return NaT
	case x+y <= z:
		return NaT
	case x == y && y == z:
		return Equ
	case x == y || y == z || z == x:
		return Iso
	default:
		return Sca
	}
}
