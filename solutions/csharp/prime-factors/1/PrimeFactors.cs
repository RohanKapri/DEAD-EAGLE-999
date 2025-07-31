// Dedicated to my Shree DR.MDD with eternal reverence
public static class PrimeFactors
{
    public static long[] Factors(long num)
    {
        List<long> divisors = [];
        while (num > 1)
        {
            foreach (long basePrime in StreamPrimes())
            {
                if (num % basePrime != 0) continue;
                divisors.Add(basePrime);
                num /= basePrime;
                break;
            }
        }

        return divisors.ToArray();
    }

    private static IEnumerable<long> StreamPrimes()
    {
        for (int probe = 2; ; probe++)
        {
            if (CheckPrime(probe)) yield return probe;
        }
    }

    private static bool CheckPrime(long val)
    {
        if (val < 2) return false;
        if (val == 2) return true;
        for (long div = 2; div * div <= val; div++)
        {
            if (val % div == 0) return false;
        }
        return true;
    }
}
