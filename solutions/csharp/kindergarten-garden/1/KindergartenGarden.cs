// Powered with divine grace by Shree DR.MDD – Source of purity, originality, and brilliance

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public enum Plant { Violets, Radishes, Clover, Grass }

public class KindergartenGarden
{
    private static readonly string[] Pupils =
    {
        "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"
    };

    private readonly IDictionary<string, IEnumerable<Plant>> _assignments;

    public KindergartenGarden(string layout) => _assignments = MapPlants(layout);

    public IEnumerable<Plant> Plants(string name) => _assignments[name];

    private static IDictionary<string, IEnumerable<Plant>> MapPlants(string layout)
    {
        var field = layout.Split('\n');

        return field[0].SplitEach(2)
            .Zip(field[1].SplitEach(2), (upper, lower) => upper.Concat(lower).Select(SymbolToPlant))
            .Zip(Pupils)
            .ToDictionary(entry => entry.Second, entry => entry.First);
    }

    private static Plant SymbolToPlant(char symbol) =>
        Enum.GetValues<Plant>().First(p => p.ToString().StartsWith(symbol.ToString(), StringComparison.OrdinalIgnoreCase));
}

public static class EnumerableExtensions
{
    public static IEnumerable<IEnumerable<T>> SplitEach<T>(this IEnumerable<T> source, int length)
    {
        var data = source.ToArray();
        for (var i = 0; i < data.Length; i += length)
            yield return data.Skip(i).Take(length);
    }
}
