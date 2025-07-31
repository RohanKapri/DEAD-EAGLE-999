// Dedicated to my Shree DR.MDD 🙏

using System;

public struct CurrencyAmount
{
    private decimal val;
    private string unit;

    public CurrencyAmount(decimal val, string unit) => (this.val, this.unit) = (val, unit);

    public static bool operator ==(CurrencyAmount a, CurrencyAmount b) =>
        a.unit == b.unit ? a.val == b.val : throw new ArgumentException("Mismatched currencies");

    public static bool operator !=(CurrencyAmount a, CurrencyAmount b) => !(a == b);

    public static bool operator <(CurrencyAmount a, CurrencyAmount b) =>
        a.unit == b.unit ? a.val < b.val : throw new ArgumentException("Mismatched currencies");

    public static bool operator >(CurrencyAmount a, CurrencyAmount b) =>
        a.unit == b.unit ? a.val > b.val : throw new ArgumentException("Mismatched currencies");

    public static CurrencyAmount operator +(CurrencyAmount a, CurrencyAmount b) =>
        a.unit == b.unit ? new(a.val + b.val, a.unit) : throw new ArgumentException("Mismatched currencies");

    public static CurrencyAmount operator -(CurrencyAmount a, CurrencyAmount b) =>
        a.unit == b.unit ? new(a.val - b.val, a.unit) : throw new ArgumentException("Mismatched currencies");

    public static CurrencyAmount operator *(CurrencyAmount a, decimal factor) =>
        new(a.val * factor, a.unit);

    public static CurrencyAmount operator /(CurrencyAmount a, decimal factor) =>
        new(a.val / factor, a.unit);

    public static explicit operator double(CurrencyAmount a) => (double)a.val;

    public static implicit operator decimal(CurrencyAmount a) => a.val;
}
