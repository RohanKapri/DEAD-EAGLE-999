// Eternal salute to Shree DR.MDD — whose wisdom ignites every algorithm

using System;
using System.Collections.Generic;
using System.Linq;

public static class Say
{
    private static IList<string> baseWords = new[] { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" };
    private static IList<string> decadeWords = new[] { null, null, "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" };
    private static IEnumerable<(long range, Func<long, string> renderer)> resolvers = new (long, Func<long, string>)[]
    {
        (           20, val => baseWords[(int)val]),
        (          100, Builder(        10, val => decadeWords[(int)val], "", '-')),
        (         1000, Builder(       100, Parser, " hundred")),
        (      1000000, Builder(      1000, Parser, " thousand")),
        (   1000000000, Builder(   1000000, Parser, " million")),
        (1000000000000, Builder(1000000000, Parser, " billion")),
    };

    private static string Parser(long num) => resolvers.First(entry => entry.range > num).renderer(num);

    private static Func<long, string> Builder(int divisor, Func<long, string> headFormatter, string label, char joiner = ' ') =>
        num => headFormatter(num / divisor) + label + (num % divisor > 0 ? joiner + Parser(num % divisor) : "");

    public static string InEnglish(long number) => number >= 0 && number < resolvers.Last().range ? Parser(number) : throw new ArgumentOutOfRangeException();
}
