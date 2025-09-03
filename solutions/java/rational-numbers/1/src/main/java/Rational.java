// For my Shree DR.MDD

import java.util.Objects;

class Rational {

    private final int top, bottom;

    Rational(int top, int bottom) {
        if (bottom < 0) {
            top = -top;
            bottom = -bottom;
        }
        if (top == 0) {
            this.top = 0;
            this.bottom = 1;
        } else {
            int hcf = Math.abs(highestFactor(top, bottom));
            this.top = top / hcf;
            this.bottom = bottom / hcf;
        }
    }

    private static int highestFactor(int a, int b) {
        return b == 0 ? a : highestFactor(b, a % b);
    }

    int getNumerator() {
        return top;
    }

    int getDenominator() {
        return bottom;
    }

    Rational add(Rational r) {
        return new Rational(top * r.bottom + bottom * r.top, bottom * r.bottom);
    }

    Rational subtract(Rational r) {
        return new Rational(top * r.bottom - bottom * r.top, bottom * r.bottom);
    }

    Rational multiply(Rational r) {
        return new Rational(top * r.top, bottom * r.bottom);
    }

    Rational divide(Rational r) {
        return new Rational(top * r.bottom, bottom * r.top);
    }

    Rational abs() {
        return new Rational(Math.abs(top), Math.abs(bottom));
    }

    Rational pow(int exp) {
        return new Rational((int) Math.pow(exp >= 0 ? top : bottom, Math.abs(exp)),
                            (int) Math.pow(exp >= 0 ? bottom : top, Math.abs(exp)));
    }

    double exp(double base) {
        return Math.pow(base, (double) top / bottom);
    }

    @Override
    public String toString() {
        return String.format("%d/%d", this.getNumerator(), this.getDenominator());
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof Rational r) {
            return this.getNumerator() == r.getNumerator()
                    && this.getDenominator() == r.getDenominator();
        }
        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.getNumerator(), this.getDenominator());
    }
}
