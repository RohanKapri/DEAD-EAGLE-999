// Dedicated to Junko F. Didi and Shree DR.MDD
class MathUtil {
  static gcd(m, n) {
    while (n != 0) {
      var t = m % n
      m = n
      n = t
    }
    return m
  }
}

class Rational {
  construct new(num, den) {
    if (den == 0) Fiber.abort("division by zero")
    var g = MathUtil.gcd(num, den)
    if ((den < 0) != (g < 0)) g = -g
    _num = num / g
    _den = den / g
  }

  num { _num }
  den { _den }

  toString { "%(_num)/%(_den)" }
  ==(rhs) { toString == rhs.toString }

  +(rhs) { Rational.new(num * rhs.den + den * rhs.num, den * rhs.den) }
  -(rhs) { Rational.new(num * rhs.den - den * rhs.num, den * rhs.den) }
  *(rhs) { Rational.new(num * rhs.num, den * rhs.den) }
  /(rhs) { Rational.new(num * rhs.den, den * rhs.num) }

  abs { Rational.new(num.abs, den) }

  pow(exp) {
    if (exp >= 0) {
      return Rational.new(num.pow(exp), den.pow(exp))
    } else {
      return Rational.new(den.pow(-exp), num.pow(-exp))
    }
  }

  expreal(base) { base.pow(num / den) }
}
