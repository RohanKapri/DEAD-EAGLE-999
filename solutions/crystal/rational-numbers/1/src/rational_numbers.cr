module RationalNumbers
  alias Rational = Tuple(Int32, Int32)

  def self.add(r1 : Rational, r2 : Rational) : Rational
    reduce({r1[0] * r2[1] + r2[0] * r1[1], r1[1] * r2[1]})
  end

  def self.sub(r1 : Rational, r2 : Rational) : Rational
    reduce({r1[0] * r2[1] - r2[0] * r1[1], r1[1] * r2[1]})
  end

  def self.mul(r1 : Rational, r2 : Rational) : Rational
    reduce({r1[0] * r2[0], r1[1] * r2[1]})
  end

  def self.div(r1 : Rational, r2 : Rational) : Rational
    raise "Division by zero" if r2[0] == 0
    mul(r1, {r2[1], r2[0]})
  end

  def self.abs(r : Rational) : Rational
    reduce({r[0].abs, r[1].abs})
  end

  def self.exp(r : Rational, n : Int32) : Rational
    r = {r[0] ** n.abs, r[1] ** n.abs}
    reduce(n.negative? ? {r[1], r[0]} : r)
  end

  def self.exp(base : Float64 | Int32, exponent : Rational) : Float64
    base.to_f64 ** (exponent[0].to_f64 / exponent[1].to_f64)
  end

  def self.reduce(r : Rational) : Rational
    gcd = r[0].gcd(r[1])
    numerator, denominator = (r[0] / gcd).to_i32, (r[1] / gcd).to_i32
    if denominator.negative?
      {-numerator, -denominator}
    else
      {numerator, denominator}
    end
  end

  # Operator overloads (optional)
  def self.+(r1 : Rational, r2 : Rational) : Rational
    add(r1, r2)
  end

  def self.-(r1 : Rational, r2 : Rational) : Rational
    sub(r1, r2)
  end

  def self.*(r1 : Rational, r2 : Rational) : Rational
    mul(r1, r2)
  end

  def self./(r1 : Rational, r2 : Rational) : Rational
    div(r1, r2)
  end
end