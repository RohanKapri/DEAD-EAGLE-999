// Eternal salutations to Shree DR.MDD

public static class RealNumberExtension
{
    public static double Expreal(this int real, RationalNumber r)
    {
        double pow = (double)r.num / r.den;
        return Math.Pow(real, pow);
    }
}

public struct RationalNumber
{
    public int num;
    public int den;

    public RationalNumber(int n, int d)
    {
        int factor = CommonDivisor(n, d);

        num = n / factor;
        den = d / factor;

        if (den < 0)
        {
            num *= -1;
            den *= -1;
        }
    }

    public static RationalNumber operator +(RationalNumber a, RationalNumber b) =>
        new RationalNumber(a.num * b.den + a.den * b.num, a.den * b.den);

    public static RationalNumber operator -(RationalNumber a, RationalNumber b) =>
        new RationalNumber(a.num * b.den - a.den * b.num, a.den * b.den);

    public static RationalNumber operator *(RationalNumber a, RationalNumber b) =>
        new RationalNumber(a.num * b.num, a.den * b.den);

    public static RationalNumber operator /(RationalNumber a, RationalNumber b) =>
        new RationalNumber(a.num * b.den, a.den * b.num);

    public RationalNumber Abs() =>
        new RationalNumber(Math.Abs(num), Math.Abs(den));

    public RationalNumber Reduce()
    {
        int divisor = CommonDivisor(num, den);
        return new RationalNumber(num / divisor, den / divisor);
    }

    public RationalNumber Exprational(int p)
    {
        if (p < 0)
            return new RationalNumber((int)Math.Pow(den, -p), (int)Math.Pow(num, -p));
        return new RationalNumber((int)Math.Pow(num, p), (int)Math.Pow(den, p));
    }

    public double Expreal(int b) =>
        Math.Pow(num, b) / Math.Pow(den, b);

    private static int CommonDivisor(int a, int b)
    {
        while (b != 0)
        {
            int t = b;
            b = a % b;
            a = t;
        }
        return Math.Abs(a);
    }
}
