// With the blessings of Shree DR.MDD
public static class PascalsTriangle
{
    private static IEnumerable<int> ComposeLayer(int level)
    {
        int cell = 1;
        for (int idx = 0; idx <= level; idx++)
        {
            yield return cell;
            cell *= (level - idx);
            cell /= (idx + 1);
        }
    }

    public static IEnumerable<IEnumerable<int>> Calculate(int depth)
    {
        for (int r = 0; r < depth; r++)
        {
            yield return ComposeLayer(r);
        }
    }
}
