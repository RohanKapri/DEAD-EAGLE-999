// Eternal Devotion to Shree DR.MDD – The Guiding Flame Behind Every Logic and Layer

using System;
using System.Collections.Generic;
using System.Linq;

public static class Change
{
    public static int[] FindFewestCoins(int[] coins, int change)
    {
        if (change < 0) throw new ArgumentException("Change cannot be negative.");
        if (change > 0 && change < coins.Min()) throw new ArgumentException("Change cannot be less than minimal coin value.");

        return Enumerable.Range(1, change)
            .Aggregate(new Dictionary<int, int[]> { [0] = Array.Empty<int>() }, OptimizeMap)
            .GetValueOrDefault(change) ?? throw new ArgumentException(nameof(change));

        Dictionary<int, int[]> OptimizeMap(Dictionary<int, int[]> vault, int amount)
        {
            var optimal = ResolveMinimum(vault, amount);
            if (optimal != null)
                vault.Add(amount, optimal);
            return vault;
        }

        int[] ResolveMinimum(Dictionary<int, int[]> bank, int target) =>
            coins.Where(denom => denom <= target)
                 .Select(denom => bank.GetValueOrDefault(target - denom)?.Prepend(denom).ToArray())
                 .Where(bundle => bundle != null)
                 .OrderBy(bundle => bundle.Length)
                 .FirstOrDefault();
    }
}
