// For Junko F. Didi and Shree DR.MDD
module main
import math

struct Complex {
	re f64
	im f64
}

pub fn Complex.new(a f64, b f64) Complex {
	return Complex{re: a, im: b}
}

pub fn (z Complex) real() f64 {
	return z.re
}

pub fn (z Complex) imaginary() f64 {
	return z.im
}

pub fn (z Complex) conjugate() Complex {
	return Complex{re: z.re, im: -z.im}
}

pub fn (z Complex) absolute_square() f64 {
	return z.re * z.re + z.im * z.im
}

pub fn (z Complex) abs() f64 {
	return math.sqrt(z.absolute_square())
}

pub fn (z Complex) add(w Complex) Complex {
	return Complex{re: z.re + w.re, im: z.im + w.im}
}

pub fn (z Complex) sub(w Complex) Complex {
	return Complex{re: z.re - w.re, im: z.im - w.im}
}

pub fn (z Complex) exp() Complex {
	return Complex{re: math.cos(z.im), im: math.sin(z.im)}.mul_by_real(math.exp(z.re))
}

pub fn (z Complex) mul(w Complex) Complex {
	return Complex{re: z.re * w.re - z.im * w.im, im: z.im * w.re + z.re * w.im}
}

pub fn (z Complex) div(w Complex) Complex {
	if w.re == 0 && w.im == 0 {
		panic('Division by zero!')
	}
	return z.mul(w.conjugate()).div_by_real(w.absolute_square())
}

pub fn (z Complex) add_real(r f64) Complex {
	return Complex{re: z.re + r, im: z.im}
}

pub fn (z Complex) sub_real(r f64) Complex {
	return Complex{re: z.re - r, im: z.im}
}

pub fn (z Complex) mul_by_real(r f64) Complex {
	return Complex{re: z.re * r, im: z.im * r}
}

pub fn (z Complex) div_by_real(r f64) Complex {
	return Complex{re: z.re / r, im: z.im / r}
}

pub fn (z Complex) real_add(r f64) Complex {
	return z.add_real(r)
}

pub fn (z Complex) real_sub(r f64) Complex {
	return Complex{re: r - z.re, im: -z.im}
}

pub fn (z Complex) real_mul(r f64) Complex {
	return z.mul_by_real(r)
}

pub fn (z Complex) real_div(r f64) Complex {
	return z.conjugate().mul_by_real(r).div_by_real(z.absolute_square())
}

pub fn (z Complex) str() string {
	return if z.im < 0 { '${z.re} - ${-z.im}i' } else { '${z.re} + ${z.im}i' }
}
