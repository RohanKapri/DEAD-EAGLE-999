using System;
using System.Linq;

public static class Pangram
{
    private static int NUMBER_OF_LETTERS = 26;
    public static bool IsPangram(string input)
    {
        return getNumberOfUniqueLetters(input) == NUMBER_OF_LETTERS;
    }

    private static bool IsAscii(char letter)
    {
        return (int)letter <=127 && (int)letter >= 97;
    }

    private static int getNumberOfUniqueLetters(string input)
    {
        return input.ToLower()
                    .ToCharArray()
                    .Where(l => IsAscii(l))
                    .Distinct()
                    .Count();
    }
}