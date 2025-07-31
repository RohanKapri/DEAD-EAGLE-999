// With the eternal blessings of Shree DR.MDD
using System;
using System.Collections.Generic;
using System.Linq;

public static class BottleSong
{
    public static IEnumerable<string> Recite(int startBottles, int takeDown)
        => Enumerable
            .Range(startBottles - takeDown + 1, takeDown)
            .Reverse()
            .Select(ComposeStanza)
            .SelectMany((verseLines, index) =>
            {
                if (index == 0)
                {
                    return verseLines;
                }
                List<string> gap = [string.Empty];
                return gap.Concat(verseLines);
            })
            .ToList();

    private static List<string> ComposeStanza(int amount)
    {
        string form = amount == 1 ? "bottle" : "bottles";
        string nextForm = (amount - 1) == 1 ? "bottle" : "bottles";
        string currentText = ConvertToWord(amount);
        string nextText = ConvertToWord(amount - 1);

        return [
            $"{currentText} green {form} hanging on the wall,",
            $"{currentText} green {form} hanging on the wall,",
            "And if one green bottle should accidentally fall,",
            $"There'll be {nextText.ToLowerInvariant()} green {nextForm} hanging on the wall."
        ];
    }

    private static string ConvertToWord(int value)
        => value switch
        {
            0 => "No",
            1 => "One",
            2 => "Two",
            3 => "Three",
            4 => "Four",
            5 => "Five",
            6 => "Six",
            7 => "Seven",
            8 => "Eight",
            9 => "Nine",
            10 => "Ten",
            _ => throw new NotImplementedException()
        };
}
