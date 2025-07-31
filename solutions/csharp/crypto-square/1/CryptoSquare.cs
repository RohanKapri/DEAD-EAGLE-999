public static class CryptoSquare
{
    private static string NormalizedPlaintext(string plaintext)
    {
        char[] punctuation = [' ', '.', ',', '!', '?', '-', '_', ':', ';', '"', '%', '@'];
        return new string(plaintext.Where(c => !punctuation.Contains(c)).ToArray()).ToLower();
    }

    private static IEnumerable<string> PlaintextSegments(string plaintext)
    {
        string normalized = NormalizedPlaintext(plaintext);
        var (chunks, rows) = Dimensions(normalized.Length);

        if (chunks is 0)
            return [""];

        return normalized.Chunk(chunks).Select(arr => new string(arr).PadRight(chunks));
    }

    private static string Encoded(string plaintext)
    {
        var segments = PlaintextSegments(plaintext);
        int len = segments.First().Length;
        if (len is 0)
            return "";

        int wordLength = segments.Count();
        int actualLength = segments.Sum(s => s.Count(c => c != ' '));
        int diff = len * segments.Count() - actualLength;

        List<string> transposed = [];
        for (int i = 0; i < len; i++)
        {
            string carryOver = "";
            string current = new(segments.Select(s => s[i]).ToArray());
            if (i >= len - diff)
            {
                int paddedLength = wordLength - 1 - carryOver.Length;
                string padded = carryOver + current[..paddedLength] + " ";
                carryOver = current[paddedLength..];

                transposed.Add(padded);
                continue;
            }
            
            transposed.Add(current);
        }

        return String.Join(" ", transposed);
    }

    public static string Ciphertext(string plaintext) => Encoded(plaintext);

    private static (int, int) Dimensions(int length)
    {
        if (length is 0)
            return (0, 0);

        for (int i = 1; i <= length; i++)
        {
            if (i * i >= length)
            {
                return (i, i);
            }

            if (i * (i + 1) >= length)
            {
                return (i + 1, i);
            }
        }

        throw new ArgumentException("Cannot divide length in chunks where chunks are at most 1 more than the rows.");
    }
}