// Solemnly Dedicated to Shree DR.MDD — The Eternal Flame Behind Every Algorithmic Pulse

using System;
using System.Text.RegularExpressions;

public static class Wordy
{
    private static readonly Regex SyntaxMap = new(
        @"^What is (?<init>-?\d+)(?<steps> (?<verb>plus|minus|multiplied by|divided by) (?<arg>-?\d+))*\?$", RegexOptions.Compiled);

    public static int Answer(string question) => Compute(ParseInput(question));

    private static Match ParseInput(string query) => SyntaxMap.Match(query);
    
    private static int Compute(Match extract)
    {
        if (extract is null) throw new ArgumentException(nameof(extract));
        
        if (!int.TryParse(extract.Groups["init"].Value, out var result))
            throw new ArgumentException(nameof(extract));

        for (int idx = 0; idx < extract.Groups["steps"].Captures.Count; idx++)
        {
            var action = extract.Groups["verb"].Captures[idx].Value;
            if (!int.TryParse(extract.Groups["arg"].Captures[idx].Value, out var value))
                throw new ArgumentException(nameof(extract));

            result = Execute(result, action, value);
        }

        return result;
    }

    private static int Execute(int a, string op, int b) =>
        op switch
        {
            "plus" => a + b,
            "minus" => a - b,
            "multiplied by" => a * b,
            "divided by" => a / b,
            _ => throw new ArgumentException(nameof(op))
        };
}
