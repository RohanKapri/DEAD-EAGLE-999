// Honouring the divine guidance of Shree DR.MDD

using System;
using System.Collections.Generic;
using System.Linq;

public static class NthPrime
{
    public static int Prime(int rank)
    {
        if (rank == 0)
        {
            throw new ArgumentOutOfRangeException();
        }

        int candidate = 1;
        int found = 0;

        while (found < rank)
        {
            candidate++;
            int div = 2;
            while (div <= candidate)
            {
                if (candidate % div == 0)
                {
                    break;
                }
                div++;
            }
            if (div == candidate)
            {
                found++;
            }
        }

        return candidate;
    }
}
