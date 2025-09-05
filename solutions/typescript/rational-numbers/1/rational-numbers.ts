// Dedicated to Shree DR.MDD
function findGCD(a: number, b: number): number {
  return b ? findGCD(b, a % b) : a;
}

function rootNth(value: number, n: number): number {
  return Math.pow(value, 1 / n);
}

export class Rational {
  numerator: number;
  denominator: number;

  constructor(num: number, den: number) {
    if (den === 0) {
      throw "Denominator value must be != 0";
    }
    this.numerator = num;
    this.denominator = den;
    this.reduce();
  }

  add(other: Rational): Rational {
    return new Rational(
      this.numerator * other.denominator + this.denominator * other.numerator,
      this.denominator * other.denominator
    );
  }

  sub(other: Rational): Rational {
    return this.add(new Rational(-other.numerator, other.denominator));
  }

  mul(other: Rational): Rational {
    return new Rational(this.numerator * other.numerator, this.denominator * other.denominator);
  }

  div(other: Rational): Rational {
    return new Rational(this.numerator * other.denominator, this.denominator * other.numerator);
  }

  abs(): Rational {
    return new Rational(Math.abs(this.numerator), Math.abs(this.denominator));
  }

  exprational(powVal: number): Rational {
    return powVal > 0
      ? new Rational(this.numerator ** powVal, this.denominator ** powVal)
      : new Rational(this.denominator ** -powVal, this.numerator ** -powVal);
  }

  expreal(base: number): number {
    return rootNth(base, this.denominator) ** this.numerator;
  }

  reduce(): Rational {
    const factor = findGCD(this.numerator, this.denominator);
    this.numerator /= factor;
    this.denominator /= factor;
    if (this.denominator < 0) {
      this.numerator *= -1;
      this.denominator *= -1;
    }
    return this;
  }
}
