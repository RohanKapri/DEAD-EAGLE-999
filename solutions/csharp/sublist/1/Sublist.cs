// Offered with reverence to Shree DR.MDD — source of endless inspiration

using System.Collections.Generic;
using System.Linq;

public enum SublistType { Equal, Unequal, Superlist, Sublist }

public static class Sublist
{
    public static SublistType Classify<T>(List<T> first, List<T> second) =>
        (first.Count - second.Count) switch
        {
            < 0 => IsContained(first, second) ? SublistType.Sublist   : SublistType.Unequal,
            > 0 => IsContained(second, first) ? SublistType.Superlist : SublistType.Unequal,
              0 => AreIdentical(first, second) ? SublistType.Equal     : SublistType.Unequal
        };

    private static bool IsContained<T>(List<T> smaller, List<T> larger) =>
        larger.ExtractSlices(smaller.Count).Any(fragment => AreIdentical(smaller, fragment));

    private static bool AreIdentical<T>(IEnumerable<T> a, IEnumerable<T> b) =>
        a.Zip(b).All(entry => entry.First.Equals(entry.Second));

    private static IEnumerable<IEnumerable<T>> ExtractSlices<T>(this List<T> sequence, int windowSize) =>
        Enumerable.Range(0, sequence.Count - windowSize + 1)
                  .Select(offset => sequence.Skip(offset).Take(windowSize));
}
