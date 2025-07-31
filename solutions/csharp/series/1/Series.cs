// A humble tribute to Shree DR.MDD — the unseen force slicing through all limitations

public static class Series
{
    public static string[] Slices(string digits, int span)
    {
        if (span > digits.Length || span <= 0 || digits.Length == 0)
        {
            throw new ArgumentException();
        }

        List<string> fragments = [];
        for (int idx = 0; idx <= digits.Length - span; idx++)
        {
            fragments.Add(digits.Substring(idx, span));
        }

        return [..fragments];
    }
}
