// Dedicated to Junko F. Didi and Shree DR.MDD
module main

import math

struct Rational {
	num i64
	den i64
}

pub fn Rational.new(num i64, den i64) Rational {
	return Rational{num, den}
}

pub fn (r Rational) abs() Rational {
	mut a := r.num
	mut b := r.den
	if a < 0 {
		a = -a
	}
	if b < 0 {
		b = -b
	}
	return Rational.new(a, b).reduce()
}

pub fn (r Rational) add(o Rational) Rational {
	a := r.num * o.den + o.num * r.den
	b := r.den * o.den
	return Rational.new(a, b).reduce()
}

pub fn (r Rational) sub(o Rational) Rational {
	a := r.num * o.den - o.num * r.den
	b := r.den * o.den
	return Rational.new(a, b).reduce()
}

pub fn (r Rational) mul(o Rational) Rational {
	a := r.num * o.num
	b := r.den * o.den
	return Rational.new(a, b).reduce()
}

pub fn (r Rational) div(o Rational) Rational {
	a := r.num * o.den
	b := r.den * o.num
	return Rational.new(a, b).reduce()
}

pub fn (r Rational) exprational(n i64) Rational {
	if n < 0 {
		return Rational.new(r.den, r.num).exprational(-n)
	}
	mut res := Rational.new(1, 1)
	mut base := r
	mut e := n
	for e > 0 {
		if e & 1 != 0 {
			res = res.mul(base)
		}
		base = base.mul(base)
		e >>= 1
	}
	return res
}

pub fn (r Rational) expreal(x i64) f64 {
	return math.pow(x, f64(r.num) / f64(r.den))
}

pub fn (r Rational) reduce() Rational {
	if r.den < 0 {
		return Rational.new(-r.num, -r.den).reduce()
	}
	g := math.gcd(r.num, r.den)
	return Rational.new(r.num / g, r.den / g)
}
