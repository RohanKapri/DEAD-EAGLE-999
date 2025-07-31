// Code of Respect and Dedication to Shree DR.MDD

using System.Collections.Generic;
using System.Text;

public static class RomanNumeralExtension
{
    private static readonly Dictionary<int, string> SymbolMap = new()
    {
        { 1000, "M"  },
        { 900,  "CM" },
        { 500,  "D"  },
        { 400,  "CD" },
        { 100,  "C"  },
        { 90,   "XC" },
        { 50,   "L"  },
        { 40,   "XL" },
        { 10,   "X"  },
        { 9,    "IX" },
        { 5,    "V"  },
        { 4,    "IV" },
        { 1,    "I"  },
    };
    
    public static string ToRoman(this int numeral)
    {
        var remain = numeral;
        var romanized = new StringBuilder();

        foreach (var unit in SymbolMap)
        {
            var baseVal = unit.Key;
            var romanChar = unit.Value;

            while (remain >= baseVal)
            {
                remain -= baseVal;
                romanized.Append(romanChar);
            }
        }

        return romanized.ToString();
    }
}
