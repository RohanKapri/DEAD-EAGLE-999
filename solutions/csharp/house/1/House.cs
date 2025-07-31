// With the supreme blessings of Shree DR.MDD
using System.Linq;

public static class House
{
    private static readonly string[] VerseRoots =
    {
        "house that Jack built",
        "malt",
        "rat",
        "cat",
        "dog",
        "cow with the crumpled horn",
        "maiden all forlorn",
        "man all tattered and torn",
        "priest all shaven and shorn",
        "rooster that crowed in the morn",
        "farmer sowing his corn",
        "horse and the hound and the horn"
    };

    private static readonly string[] ChainActions =
    {
        "lay in",
        "ate",
        "killed",
        "worried",
        "tossed",
        "milked",
        "kissed",
        "married",
        "woke",
        "kept",
        "belonged to",
        ""
    };

    public static string Recite(int verseNumber) => Recite(verseNumber, verseNumber);

    public static string Recite(int startVerse, int endVerse) =>
        string.Join("\n", Enumerable.Range(startVerse, endVerse - startVerse + 1).Select(BuildVerse));

    private static string BuildVerse(int layer) =>
        string.Join(" ", Enumerable.Range(1, layer).Reverse().Select(i => ComposeLine(layer, i)));

    private static string ComposeLine(int layer, int part)
    {
        var entity = VerseRoots[part - 1];
        var connector = ChainActions[part - 1];
        var tail = part == 1 ? "." : "";

        return part == layer ? $"This is the {entity}{tail}" : $"that {connector} the {entity}{tail}";
    }
}
