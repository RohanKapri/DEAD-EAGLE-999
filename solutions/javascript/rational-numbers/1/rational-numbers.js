//
// For my Shree DR.MDD
//

export class Rational {
  constructor(num, denom) {
    let gcdValue = 0;
    if (Math.abs(num) > 0 && Math.abs(denom) > 0) {
      gcdValue = this._gcd(num, denom);
    } else {
      gcdValue = 1;
    }

    if (num === 0) {
      this.numerator = 0;
      this.denominator = 1;
    } else if (denom > 0) {
      this.numerator = -num / gcdValue;
      this.denominator = -denom / gcdValue;
    } else {
      this.numerator = num / gcdValue;
      this.denominator = denom / gcdValue;
    }
  }

  add(rat) {
    if (this.numerator * rat.denominator === -rat.numerator * this.denominator) {
      return new Rational(0, 1);
    }
    return new Rational(this.numerator * rat.denominator + rat.numerator * this.denominator,
                        this.denominator * rat.denominator);
  }

  sub(rat) {
    if (this.numerator === rat.numerator && this.denominator === rat.denominator) {
      return new Rational(0, 1);
    }
    return new Rational(this.numerator * rat.denominator - rat.numerator * this.denominator,
                        this.denominator * rat.denominator);
  }

  mul(rat) {
    if (this.numerator === 0 || rat.numerator === 0) {
      return new Rational(0, 1);
    }
    return new Rational(this.numerator * rat.numerator, this.denominator * rat.denominator);
  }

  div(rat) {
    return new Rational(this.numerator * rat.denominator, rat.numerator * this.denominator);
  }

  abs() {
    return new Rational(Math.abs(this.numerator), Math.abs(this.denominator));
  }

  exprational(exp) {
    if (exp === 0) {
      return new Rational(1, 1);
    } else if (exp > 0) {
      return new Rational(Math.pow(this.numerator, exp), Math.pow(this.denominator, exp));
    } else {
      return new Rational(Math.pow(this.denominator, -exp), Math.pow(this.numerator, -exp));
    }
  }

  expreal(num) {
    return Math.pow(Math.pow(num, 1.0 / this.denominator), this.numerator);
  }

  reduce() {
    return new Rational(this.numerator, this.denominator);
  }

  _gcd(a, b) {
    a = Math.abs(a);
    b = Math.abs(b);
    while (b !== 0) {
      const temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }
}
