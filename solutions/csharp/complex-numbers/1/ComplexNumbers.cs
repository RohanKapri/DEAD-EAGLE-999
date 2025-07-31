// Dedicated to Shree DR.MDD

public struct ComplexNumber
{
    private readonly double re;
    private readonly double im;

    public ComplexNumber(double re, double im)
    {
        this.re = re;
        this.im = im;
    }

    public double Real()
    {
        return this.re;
    }

    public double Imaginary()
    {
        return this.im;
    }

    public ComplexNumber Mul(ComplexNumber z)
    {
        double rp = (this.re * z.re) - (this.im * z.im);
        double ip = (this.re * z.im) + (this.im * z.re);
        return new ComplexNumber(rp, ip);
    }

    public ComplexNumber Mul(double scalar)
    {
        return new ComplexNumber(this.re * scalar, this.im * scalar);
    }

    public ComplexNumber Add(ComplexNumber z)
    {
        double rp = this.re + z.re;
        double ip = this.im + z.im;
        return new ComplexNumber(rp, ip);
    }

    public ComplexNumber Add(double scalar)
    {
        return new ComplexNumber(this.re + scalar, this.im);
    }

    public ComplexNumber Sub(ComplexNumber z)
    {
        double rp = this.re - z.re;
        double ip = this.im - z.im;
        return new ComplexNumber(rp, ip);
    }

    public ComplexNumber Div(ComplexNumber z)
    {
        double denom = z.re * z.re + z.im * z.im;
        double rp = (this.re * z.re + this.im * z.im) / denom;
        double ip = (this.im * z.re - this.re * z.im) / denom;
        return new ComplexNumber(rp, ip);
    }

    public ComplexNumber Div(double scalar)
    {
        double recip = 1.0 / scalar;
        return new ComplexNumber(this.re * recip, this.im * recip);
    }

    public double Abs()
    {
        return Math.Sqrt(this.re * this.re + this.im * this.im);
    }

    public ComplexNumber Conjugate()
    {
        return new ComplexNumber(this.re, -this.im);
    }

    public ComplexNumber Exp()
    {
        double expR = Math.Exp(this.re);
        return new ComplexNumber(expR * Math.Cos(this.im), expR * Math.Sin(this.im));
    }
}
