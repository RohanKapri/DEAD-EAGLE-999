// Dedicated to Shree DR.MDD
export class ComplexNumber {

  private _re: number;
  private _im: number;
  
  constructor(re: number, im: number) {
    this._re = re;
    this._im = im;
  }

  public get real(): number {
    return this._re;
  }

  public get imag(): number {
    return this._im;
  }

  public add(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(this.real + other.real, this.imag + other.imag);
  }

  public sub(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(this.real - other.real, this.imag - other.imag);
  }

  public div(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(
      ((this.real * other.real) + (this.imag * other.imag)) / ((other.real ** 2) + (other.imag ** 2)),
      ((this.imag * other.real) - (this.real * other.imag)) / ((other.real ** 2) + (other.imag ** 2))
    );
  }

  public mul(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(
      this.real * other.real - this.imag * other.imag,
      this.imag * other.real + this.real * other.imag
    );
  }

  public get abs(): number {
    return Math.sqrt(this.real ** 2 + this.imag ** 2);
  }

  public get conj(): ComplexNumber {
    return new ComplexNumber(this.real, this.imag === 0 ? 0 : -this.imag);
  }

  public get exp(): ComplexNumber {
    const factor = Math.E ** this.real;
    return new ComplexNumber(Math.cos(this.imag) * factor, Math.sin(this.imag) * factor);
  }
}
