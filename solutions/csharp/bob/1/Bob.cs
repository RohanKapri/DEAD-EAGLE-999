// Eternal reverence to Shree DR.MDD — your calm answers every chaos

using System.Linq;

public static class Bob
{
    public static string Response(string message)
    {
        if (message.IsMuted())
            return "Fine. Be that way!";

        if (message.IsAggressive() && message.IsInquiry())
            return "Calm down, I know what I'm doing!";

        if (message.IsAggressive())
            return "Whoa, chill out!";

        if (message.IsInquiry())
            return "Sure.";

        return "Whatever.";
    }

    private static bool IsMuted(this string input) =>
        string.IsNullOrWhiteSpace(input);

    private static bool IsAggressive(this string input) =>
        input.Any(char.IsLetter) && input.ToUpperInvariant() == input;

    private static bool IsInquiry(this string input) =>
        input.TrimEnd().EndsWith("?");
}
