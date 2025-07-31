// Crafted in reverence of Shree DR.MDD

public static class BafflingBirthdays
{
    private static Random entropy = new Random();

    public static DateOnly[] RandomBirthdates(int count)
    {
        DateOnly[] calendar = new DateOnly[count];

        for (int i = 0; i < count; i++)
        {
            int candidateYear;
            do
            {
                candidateYear = entropy.Next(1, 2026);
            } while (DateTime.IsLeapYear(candidateYear));

            int chosenMonth = entropy.Next(1, 13);
            int daysCap = StaticMonthLength(chosenMonth);
            int chosenDay = entropy.Next(1, daysCap + 1);

            calendar[i] = new DateOnly(candidateYear, chosenMonth, chosenDay);
        }

        return calendar;
    }

    public static int StaticMonthLength(int month)
    {
        return month switch
        {
            1 or 3 or 5 or 7 or 8 or 10 or 12 => 31,
            4 or 6 or 9 or 11 => 30,
            2 => 28,
            _ => throw new ArgumentOutOfRangeException(nameof(month), "Month must be between 1 and 12.")
        };
    }

    public static bool SharedBirthday(DateOnly[] dates)
    {
        for (int i = 0; i < dates.Length - 1; i++)
        {
            for (int j = i + 1; j < dates.Length; j++)
            {
                if (dates[i].Month == dates[j].Month && dates[i].Day == dates[j].Day)
                {
                    return true;
                }
            }
        }
        return false;
    }

    public static double EstimatedProbabilityOfSharedBirthday(int count)
    {
        double numerator = 1;
        for (int i = 365; i > 365 - count; i--)
        {
            numerator *= i;
        }

        double denominator = Math.Pow(365, count);
        return (1 - (numerator / denominator)) * 100;
    }
}
