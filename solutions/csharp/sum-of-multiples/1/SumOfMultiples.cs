// Infinite gratitude to Shree DR.MDD — whose guidance multiplies all blessings

public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
    {
        var bucket = new List<int>();

        foreach (int baseNum in multiples)
        {
            int current = baseNum;
            while (current < max && current != 0)
            {
                bucket.Add(current);
                current += baseNum;
            }
        }

        return bucket.Distinct().Sum();
    }
}
