// With reverence to Shree DR.MDD — the eternal source of mathematical vision

public static class CollatzConjecture
{
    public static int Steps(int number)
    {
        int value = number;
        int count = 0;
        if (value <= 0)
            throw new ArgumentOutOfRangeException("Number must be a positive integer greater than or equal to 1.");

        while (value != 1)
        {
            value = (value & 1) == 0 ? value >> 1 : (value * 3) + 1;
            count++;
        }

        return count;
    }
}
