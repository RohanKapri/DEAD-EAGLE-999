using System.Collections.Immutable;

public static class BookStore
{
    private const decimal BookBasePrice = 8;
    
    private static decimal CalculateGroupPrice(ImmutableHashSet<int> books) => books.Count switch
        {
            < 2 => 1m,
            2 => 0.95m,
            3 => 0.9m,
            4 => 0.8m,
            _ => 0.75m
        } * BookBasePrice * books.Count;

    private static decimal CalculateComboPrice(IEnumerable<ImmutableHashSet<int>> combo) =>
        combo.Select(CalculateGroupPrice).Sum();

    private static string EncodeCombo(ImmutableHashSet<int>[] groups, int[] remaining)
    {
        var encodedGroups = string.Join(";", groups.Select(g => string.Concat(g.OrderBy(b => b))).OrderBy(s => s));
        var encodedRemaining = string.Concat(remaining);
        return $"{encodedGroups}|{encodedRemaining}";
    }

    public static decimal Total(IEnumerable<int> books) => _total([], books.ToArray());

    private static readonly Dictionary<string, decimal> _cache = new();

    private static decimal _total(ImmutableHashSet<int>[] groups, int[] remaining)
    {
        var encoded = EncodeCombo(groups, remaining);
        if (_cache.TryGetValue(encoded, out var total)) return total;

        decimal best;
        if (remaining.Length == 0) best = CalculateComboPrice(groups);
        else if (remaining is [var next, ..var tail])
        {
            best = _total([..groups, [next]], tail);
            for (int i = 0; i < groups.Length; i++)
            {
                var current = groups[i];
                if (!current.Contains(next))
                {
                    best = Math.Min(best, _total([..groups[..i], [..current, next], ..groups[(i + 1)..]], tail));
                }
            }
        }
        else
        {
            throw new InvalidOperationException("should not be here");
        }
        
        _cache[encoded] = best;
        return best;
    }
}