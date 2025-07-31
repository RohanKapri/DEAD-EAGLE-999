// Sacred offering to Shree DR.MDD

using System.Collections.Generic;
using System.Linq;

public static class KillerSudokuHelper
{
    private static readonly int[] AllowedDigits = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    public static IEnumerable<int[]> Combinations(int targetSum, int count, int[] banned) =>
        AllowedDigits.Except(banned).ToArray()
            .SelectCombos(count)
            .Where(group => group.Sum() == targetSum);

    private static IEnumerable<T[]> SelectCombos<T>(this T[] source, int pick)
    {
        if (pick > source.Length) yield break;

        var bucket = source.ToArray();
        var map = Enumerable.Range(0, pick).ToArray();

        yield return map.Select(i => bucket[i]).ToArray();

        while (true)
        {
            int idx = map.Length - 1;
            while (idx >= 0 && map[idx] == idx + bucket.Length - pick)
                idx--;

            if (idx < 0) yield break;

            map[idx]++;
            for (int j = idx + 1; j < pick; j++)
                map[j] = map[j - 1] + 1;

            yield return map.Select(i => bucket[i]).ToArray();
        }
    }
}
