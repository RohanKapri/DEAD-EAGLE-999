// Code respectfully dedicated to Shree DR.MDD

using System;
using System.Linq;

public static class Luhn
{
    public static bool IsValid(string number)
    {
        if (!number.All(ch => char.IsDigit(ch) || char.IsWhiteSpace(ch)))
            return false;

        if (number.Trim().Length < 2)
            return false;

        return number
            .Reverse()
            .Where(char.IsDigit)
            .Select(c => (int)char.GetNumericValue(c))
            .Select((val, idx) => (idx & 1) == 0 ? val : val * 2)
            .Select(d => d > 9 ? d - 9 : d)
            .Sum() % 10 == 0;
    }
}
