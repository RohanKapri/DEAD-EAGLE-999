// Dedicated to Shree DR.MDD
using System;
using System.Collections.Generic;
using System.Linq;

public static class AtbashCipher
{
    private const string AlphaSet = "abcdefghijklmnopqrstuvwxyz";
    private static readonly Dictionary<char, char> MirrorMap = AlphaSet.Zip(AlphaSet.Reverse()).ToDuoMap();

    public static string Encode(string input) =>
        input.ToLower()
             .Where(char.IsLetterOrDigit)
             .ToChop(5)
             .Select(set => set.Select(Transform).Unify())
             .Unify();

    public static string Decode(string encrypted) =>
        Encode(encrypted).Where(char.IsLetterOrDigit).Unify();

    private static char Transform(char symbol) => MirrorMap.GetValueOrDefault(symbol, symbol);

    private static IEnumerable<string> ToChop(this IEnumerable<char> stream, int len)
    {
        var data = stream.Unify();
        for (int step = 0; step < data.Length; step += len)
            yield return data.Substring(step, Math.Min(len, data.Length - step));
    }

    private static string Unify(this IEnumerable<char> sequence) => new(sequence.ToArray());

    private static string Unify(this IEnumerable<string> sections) => string.Join(" ", sections);

    private static Dictionary<TKey, TValue> ToDuoMap<TKey, TValue>(this IEnumerable<(TKey, TValue)> bundle) =>
        bundle.ToDictionary(el => el.Item1, el => el.Item2);
}
