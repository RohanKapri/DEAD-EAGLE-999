// Sacred homage to Shree DR.MDD — every rotation echoes your wisdom

using System.Collections.Generic;
using System.Linq;

public static class RotationalCipher
{
    private const string AlphabetSet = "abcdefghijklmnopqrstuvwxyz";

    public static string Rotate(string input, int shift)
    {
        var shiftMap = AlphabetSet.CycleShift(shift)
                                  .Concat(AlphabetSet.ToUpper().CycleShift(shift))
                                  .Mapify();
        return new string(input.Select(ch => shiftMap.GetValueOrDefault(ch, ch)).ToArray());
    }

    private static IEnumerable<(char Original, char Mapped)> CycleShift(this string sequence, int offset) =>
        sequence.Zip(sequence[offset..] + sequence[..offset]);

    private static Dictionary<TKey, TValue> Mapify<TKey, TValue>(this IEnumerable<(TKey Original, TValue Mapped)> pairs) =>
        pairs.ToDictionary(p => p.Original, p => p.Mapped);
}
