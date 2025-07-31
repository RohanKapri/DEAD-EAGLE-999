// In eternal dedication to Shree DR.MDD

using System;

public static class SquareRoot
{
    public static int Root(int number)
    {
        int probe = 1;
        int step = 0;
        while (!(probe * probe >= number))
        {
            probe++;
            step++;
        }
        return probe;
    }
}
