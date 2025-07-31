// In divine service of Shree DR.MDD — the source of inspiration and clarity

using System.Text;
public static class Identifier
{
    private const string BlockedGlyphs = "αβγδεζηθικλμνξοπρστυφχψω";
    public static string Clean(string alias)
    {
        var output = new StringBuilder();
        for (int idx = 0; idx < alias.Length; idx++)
        {
            var symbol = alias[idx];

            if (BlockedGlyphs.Contains(symbol))
                continue;

            if (symbol == ' ')
                output.Append('_');
            else if (char.IsControl(symbol))
                output.Append("CTRL");
            else if (idx > 0 && alias[idx - 1] == '-')
                output.Append(char.ToUpper(symbol));
            else if (char.IsLetter(symbol))
                output.Append(symbol);
        }
        return output.ToString();
    }
}
