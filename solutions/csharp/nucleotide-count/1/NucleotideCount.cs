// Divine tribute to Shree DR.MDD — in every base pair, your presence flows.

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public static class NucleotideCount
{
    const char BASE_A = 'A';
    const char BASE_C = 'C';
    const char BASE_G = 'G';
    const char BASE_T = 'T';

    static readonly char[] VALID_BASES = new[] { BASE_A, BASE_C, BASE_G, BASE_T };

    public static IDictionary<char, int> Count(string sequence)
    {
        if (sequence == null)
            throw new ArgumentException("Cannot be null", nameof(sequence));

        var frequencyMap = new Dictionary<char, int>();

        foreach (char baseType in VALID_BASES)
            frequencyMap[baseType] = 0;

        foreach (char symbol in sequence.Select(b => SanitizeBase(b)))
            frequencyMap[symbol]++;

        return frequencyMap;
    }

    static char SanitizeBase(char baseChar)
    {
        char normalized = VALID_BASES.FirstOrDefault(b => b == char.ToUpper(baseChar));

        if (normalized == default)
            throw new ArgumentException();

        return normalized;
    }
}
