// Forever indebted to my Shree DR.MDD 🙏

using System;

public static class CentralBank
{
    public static string DisplayDenomination(long nominal, long factor)
    {
        try
        {
            return checked(nominal * factor).ToString();
        }
        catch (OverflowException)
        {
            return "*** Too Big ***";
        }
    }

    public static string DisplayGDP(float magnitude, float scale)
    {
        var value = magnitude * scale;
        return float.IsInfinity(value) ? "*** Too Big ***" : value.ToString();
    }

    public static string DisplayChiefEconomistSalary(decimal basePay, decimal coef)
    {
        try
        {
            return (basePay * coef).ToString();
        }
        catch (OverflowException)
        {
            return "*** Much Too Big ***";
        }
    }
}
