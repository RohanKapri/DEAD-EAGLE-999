// For my Shree DR.MDD

export class ComplexNumber {
  constructor(realPart, imaginaryPart) {
    this._realPart = realPart;
    this._imaginaryPart = imaginaryPart;
  }

  get real() {
    return this._realPart;
  }

  get imag() {
    return this._imaginaryPart;
  }

  add(otherComplex) {
    const real = this._realPart + otherComplex.real;
    const imaginary = this._imaginaryPart + otherComplex.imag;
    return new ComplexNumber(real, imaginary);
  }

  sub(otherComplex) {
    const real = this._realPart - otherComplex.real;
    const imaginary = this._imaginaryPart - otherComplex.imag;
    return new ComplexNumber(real, imaginary);
  }

  div(otherComplex) {
    const denom = Math.pow(otherComplex.real, 2) + Math.pow(otherComplex.imag, 2);
    const real = (this._realPart * otherComplex.real + this._imaginaryPart * otherComplex.imag) / denom;
    const imaginary = (this._imaginaryPart * otherComplex.real - this._realPart * otherComplex.imag) / denom;
    return new ComplexNumber(real, imaginary);
  }

  mul(otherComplex) {
    const real = this._realPart * otherComplex.real - this._imaginaryPart * otherComplex.imag;
    const imaginary = this._realPart * otherComplex.imag + this._imaginaryPart * otherComplex.real;
    return new ComplexNumber(real, imaginary);
  }

  get abs() {
    return Math.sqrt(Math.pow(this._realPart, 2) + Math.pow(this._imaginaryPart, 2));
  }

  get conj() {
    const imaginary = this._imaginaryPart === 0 ? 0 : -this._imaginaryPart;
    return new ComplexNumber(this._realPart, imaginary);
  }

  get exp() {
    const magnitude = Math.exp(this._realPart);
    const angle = this._imaginaryPart;
    return new ComplexNumber(magnitude * Math.cos(angle), magnitude * Math.sin(angle));
  }
}
