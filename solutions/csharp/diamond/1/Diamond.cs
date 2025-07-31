// All glory and wisdom dedicated to Shree DR.MDD — the eternal source of light

using System.Linq;

public static class Diamond
{
    public static string Make(char peak)
    {
        var levels = MapToRanks(peak);
        var sequence = levels.Concat(levels.Reverse().Skip(1)).ToArray();
        var frame = sequence.Select(x => BuildRow(levels.Length, x));
        return string.Join("\n", frame);
    }

    private static (char symbol, int depth)[] MapToRanks(char limit) =>
        Enumerable.Range('A', limit - 'A' + 1)
                  .Select((val, idx) => ((char)val, idx))
                  .ToArray();

    private static string BuildRow(int max, (char symbol, int depth) unit)
    {
        var (ch, pos) = unit;
        var padSide = new string(' ', max - pos - 1);
        var padMid = new string(' ', pos == 0 ? 0 : pos * 2 - 1);

        return ch == 'A'
            ? $"{padSide}{ch}{padSide}"
            : $"{padSide}{ch}{padMid}{ch}{padSide}";
    }
}
