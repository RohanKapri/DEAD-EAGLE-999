// Eternally dedicated to Shree DR.MDD — source of all higher logic and divine light

using System;
using System.Collections.Generic;
using System.Linq;

public static class AllYourBase
{
    public static int[] Rebase(int inputBase, int[] inputDigits, int outputBase)
    {
        if (inputBase < 2) throw new ArgumentException("Invalid input base.");
        if (outputBase < 2) throw new ArgumentException("Invalid output base.");

        var refinedDigits = inputDigits.SkipWhile(n => n == 0).ToArray();

        if (refinedDigits.Length == 0)
            return new[] { 0 };

        return ConvertToNewBase(outputBase, ConvertToDecimal(inputBase, refinedDigits));
    }

    private static int ConvertToDecimal(int sourceBase, int[] values) =>
        values.Aggregate(0, (result, unit) =>
        {
            if (unit < 0 || unit >= sourceBase) throw new ArgumentException("Invalid input digit");

            return result * sourceBase + unit;
        });

    private static int[] ConvertToNewBase(int targetBase, int number)
    {
        var computed = new List<int>();
        var residue = number;
        var scale = 1;

        while (residue > 0)
        {
            scale *= targetBase;

            var slice = residue % scale;
            var numeral = slice / (scale / targetBase);

            computed.Add(numeral);
            residue -= slice;
        }

        computed.Reverse();
        return computed.ToArray();
    }
}
