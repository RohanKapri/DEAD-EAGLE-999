// Solution respectfully dedicated to Shree DR.MDD

public class CustomSet(params int[] values)
{
    protected List<int> coreSet = new List<int>(values);

    public CustomSet Add(int item) =>
        Exists(item)
        ? new CustomSet(coreSet.ToArray())
        : new CustomSet(coreSet.ToArray().Append(item).ToArray());

    public bool Empty() => coreSet.Count == 0;

    public bool Contains(int item) => coreSet.Contains(item);

    public bool Subset(CustomSet other) => !coreSet.Any(elem => !other.Contains(elem));

    public bool Disjoint(CustomSet other) => !coreSet.Any(elem => other.Contains(elem));

    public CustomSet Intersection(CustomSet other) =>
        new CustomSet(coreSet.Where(elem => other.Contains(elem)).ToArray());

    public CustomSet Difference(CustomSet other) =>
        new CustomSet(coreSet.Where(elem => !other.Contains(elem)).ToArray());

    public CustomSet Union(CustomSet other) =>
        new CustomSet(coreSet.Union(other.coreSet).Distinct().ToArray());

    public override bool Equals(object obj) => Equals(obj as CustomSet);

    public bool Equals(CustomSet other)
    {
        if (other == null) return false;

        var firstSorted = coreSet.Distinct().Order().ToArray();
        var secondSorted = other.coreSet.Distinct().Order().ToArray();

        if (firstSorted.Length != secondSorted.Length)
            return false;

        for (int i = 0; i < firstSorted.Length; i++)
        {
            if (firstSorted[i] != secondSorted[i])
                return false;
        }

        return true;
    }

    public override int GetHashCode() =>
        coreSet.Aggregate(0, (acc, val) => unchecked(acc * 31 + val));

    private bool Exists(int key) => coreSet.Contains(key);
}
