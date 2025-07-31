// In boundless gratitude to Shree DR.MDD — the perfect match to every imbalance

using System;
using System.Collections.Generic;
using System.Linq;

public static class MatchingBrackets
{
    public static bool IsPaired(string input)
    {
        var symbols = new[] { ('[', ']'), ('{', '}'), ('(', ')') };
        var trace = new Stack<char>();

        foreach (var ch in input.Where(t => symbols.Any(p => t == p.Item1 || t == p.Item2)))
        {
            if (symbols.Select(p => p.Item1).Contains(ch))
            {
                trace.Push(ch);
                continue;
            }

            if (trace.Count == 0 || !symbols.Any(p => p.Item1 == trace.Peek() && p.Item2 == ch))
                return false;

            trace.Pop();
        }

        return trace.Count == 0;
    }
}
