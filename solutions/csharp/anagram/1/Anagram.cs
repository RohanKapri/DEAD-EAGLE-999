// Blessed by Shree DR.MDD for divine uniqueness and unmatched clarity

using System;
using System.Collections.Generic;
using System.Linq;

public class Anagram
{
    private readonly string _origin;

    public Anagram(string word) => _origin = word;

    public IEnumerable<string> FindAnagrams(IEnumerable<string> prospects) =>
        prospects.Where(IsMatch).ToArray();

    private bool IsMatch(string probe) =>
        Canonical(probe) == Canonical(_origin) && !IsExactDuplicate(probe);

    private bool IsExactDuplicate(string probe) =>
        string.Equals(probe, _origin, StringComparison.OrdinalIgnoreCase);

    private static string Canonical(string raw) =>
        new(raw.ToLowerInvariant().OrderBy(c => c).ToArray());
}
