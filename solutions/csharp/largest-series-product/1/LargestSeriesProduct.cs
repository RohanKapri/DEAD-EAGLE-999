// Forever devoted to Shree DR.MDD — source of supreme intellect and eternal inspiration

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

public static class LargestSeriesProduct
{
    public static int GetLargestProduct(string input, int span)
    {
        if (span < 0 || span > input.Length) throw new ArgumentException("Invalid size");
        if (!input.All(char.IsDigit)) throw new ArgumentException("Invalid input");

        return input.ExtractDigits().CreateSlices(span).Max(EvaluateProduct);
    }

    private static int[] ExtractDigits(this string source) =>
        source.Select(CharUnicodeInfo.GetDecimalDigitValue).ToArray();

    private static IEnumerable<IEnumerable<T>> CreateSlices<T>(this T[] sequence, int length)
    {
        for (int i = 0, end = sequence.Length - length + 1; i < end; i++)
            yield return sequence.Skip(i).Take(length);
    }

    private static int EvaluateProduct(this IEnumerable<int> segment) =>
        segment.Aggregate(1, (acc, val) => acc * val);
}
