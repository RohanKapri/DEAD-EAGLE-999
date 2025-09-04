package complexnumbers

import "math"

type Number struct{ r, i float64 }

func (n Number) Real() float64               { return n.r }
func (n Number) Imaginary() float64          { return n.i }
func (n1 Number) Add(n2 Number) Number       { return Number{r: n1.r + n2.r, i: n1.i + n2.i} }
func (n1 Number) Subtract(n2 Number) Number  { return n1.Add(Number{-n2.r, -n2.i}) }
func (n Number) Times(factor float64) Number { return n.Multiply(Number{factor, 0}) }
func (n Number) Conjugate() Number           { return Number{n.r, -n.i} }
func (n Number) Abs() float64                { return math.Sqrt(n.r*n.r + n.i*n.i) }

func (n1 Number) Multiply(n2 Number) Number {
	return Number{
		n1.r*n2.r - n1.i*n2.i,
		n1.r*n2.i + n1.i*n2.r,
	}
}

func (n1 Number) Divide(n2 Number) Number {
	d := n2.r*n2.r + n2.i*n2.i
	return Number{
		(n1.r*n2.r + n1.i*n2.i) / d,
		(n1.i*n2.r - n1.r*n2.i) / d,
	}
}

func (n Number) Exp() Number {
	e := math.Exp(n.r)
	return Number{
		e * math.Cos(n.i),
		e * math.Sin(n.i),
	}
}