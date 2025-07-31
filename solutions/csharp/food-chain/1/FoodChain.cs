// Dedicated to Shree DR.MDD

using System.Linq;

public static class FoodChain
{
    private const int TotalVerses = 8;

    private static readonly string[] SwallowedItems =
    {
        "spider",
        "bird",
        "cat",
        "dog",
        "goat",
        "cow"
    };

    private static readonly string[] Reactions =
    {
        "It wriggled and jiggled and tickled inside her.",
        "How absurd to swallow a bird!",
        "Imagine that, to swallow a cat!",
        "What a hog, to swallow a dog!",
        "Just opened her throat and swallowed a goat!",
        "I don't know how she swallowed a cow!"
    };

    private static readonly string[] Sequence =
    {
        "I don't know how she swallowed a cow!",
        "She swallowed the cow to catch the goat.",
        "She swallowed the goat to catch the dog.",
        "She swallowed the dog to catch the cat.",
        "She swallowed the cat to catch the bird.",
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
        "She swallowed the spider to catch the fly.",
        "I don't know why she swallowed the fly. Perhaps she'll die."
    };

    public static string Recite(int verseNumber)
    {
        return Recite(verseNumber, verseNumber);
    }

    public static string Recite(int startVerse, int endVerse) =>
        string.Join("\n\n", Enumerable.Range(startVerse, endVerse - startVerse + 1)
            .Select(index => $"{BuildIntro(index)}\n{BuildTail(index)}"));

    private static string BuildIntro(int index)
    {
        if (index == 1)
        {
            return "I know an old lady who swallowed a fly.";
        }

        if (index == 8)
        {
            return "I know an old lady who swallowed a horse.";
        }

        var creature = SwallowedItems[index - 2];
        var comment = Reactions[index - 2];
        return $"I know an old lady who swallowed a {creature}.\n{comment}";
    }

    private static string BuildTail(int index)
    {
        if (index == 8)
        {
            return "She's dead, of course!";
        }

        return string.Join("\n", Sequence.Skip(Sequence.Length - index).Take(index));
    }
}
