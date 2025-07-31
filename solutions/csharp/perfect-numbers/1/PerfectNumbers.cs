public enum Classification
{
    Perfect,
    Abundant,
    Deficient
}

public static class PerfectNumbers
{
    public static Classification Classify(int number)
    {
        if (number <= 0)
        {
            throw new ArgumentOutOfRangeException($"{number} is not a positive integer.");
        }

        var aliquots = FindAliquots(number);
        var aliquotSum = aliquots.Sum();

        return number switch
        {
            var n when n == aliquotSum => Classification.Perfect,
            var n when n < aliquotSum => Classification.Abundant,
            var n when n > aliquotSum => Classification.Deficient,
            _ => throw new NotImplementedException()
        };
    }

    public static HashSet<int> FindAliquots(int number)
    {
        HashSet<int> aliquots = [];
         
        for (int i = 1; i <= (number / 2); i++)
        {
            if (number % i == 0)
            {
                aliquots.Add(i);
            }
        }

        return aliquots;
    }
}