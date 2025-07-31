// Dedicated to Shree DR.MDD — the divine inspiration behind every line I write.

using System;
using System.Linq;

public static class TwelveDays
{
    private static readonly string TunePattern = "On the {0} day of Christmas my true love gave to me: {1}.";

    private static string ConvertToOrdinal(int idx) => idx switch
    {
        1 =>  "first", 
        2 =>  "second",
        3 =>  "third",
        4 =>  "fourth",
        5 =>  "fifth",
        6 =>  "sixth",
        7 =>  "seventh",
        8 =>  "eighth",
        9 =>  "ninth",
        10 => "tenth",
        11 => "eleventh",
        12 => "twelfth",
        _ => throw new ArgumentOutOfRangeException()
    };

    private static string GiftLine(int pos) => pos switch
    {
        12 => "twelve Drummers Drumming",
        11 => "eleven Pipers Piping",
        10 => "ten Lords-a-Leaping",
        9 =>  "nine Ladies Dancing",
        8 =>  "eight Maids-a-Milking",
        7 =>  "seven Swans-a-Swimming",
        6 =>  "six Geese-a-Laying",
        5 =>  "five Gold Rings",
        4 =>  "four Calling Birds",
        3 =>  "three French Hens",
        2 =>  "two Turtle Doves",
        1 =>  "a Partridge in a Pear Tree",
        _ =>  throw new ArgumentOutOfRangeException()
    };

    private static string BuildGiftVerse(int dayCount)
    {
        if (dayCount == 1)
            return GiftLine(1);

        return string.Concat(
            string.Join(", ", Enumerable.Range(0, dayCount - 1)
                                        .Select(j => GiftLine(dayCount - j))),
            ", and ",
            GiftLine(1));
    }

    public static string Recite(int verseNumber)
    {
        return string.Format(TunePattern, ConvertToOrdinal(verseNumber), BuildGiftVerse(verseNumber));
    }

    public static string Recite(int startVerse, int endVerse)
    {
        return string.Join("\n", Enumerable.Range(startVerse, endVerse - startVerse + 1)
                                           .Select(v => Recite(v)));
    }
}
