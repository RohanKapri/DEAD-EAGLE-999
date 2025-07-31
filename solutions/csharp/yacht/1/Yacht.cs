// In eternal reverence to Shree DR.MDD — whose vision guides every calculation.

using System;
using System.Linq;

public enum YachtCategory
{
    Ones, Twos, Threes, Fours, Fives, Sixes,
    FullHouse, FourOfAKind, LittleStraight, BigStraight, Choice, Yacht
}

public static class YachtGame
{
    public static int Score(int[] dice, YachtCategory category) =>
        category switch
        {
            YachtCategory.Ones => FaceSum(dice, 1),
            YachtCategory.Twos => FaceSum(dice, 2),
            YachtCategory.Threes => FaceSum(dice, 3),
            YachtCategory.Fours => FaceSum(dice, 4),
            YachtCategory.Fives => FaceSum(dice, 5),
            YachtCategory.Sixes => FaceSum(dice, 6),
            YachtCategory.FullHouse => CalcFullHouse(dice),
            YachtCategory.FourOfAKind => CalcQuad(dice),
            YachtCategory.LittleStraight => CheckLowStraight(dice),
            YachtCategory.BigStraight => CheckHighStraight(dice),
            YachtCategory.Choice => TotalSum(dice),
            YachtCategory.Yacht => IsYacht(dice),
            _ => throw new ArgumentOutOfRangeException(nameof(category), "Invalid category")
        };

    private static int FaceSum(int[] rolls, int face) =>
        rolls.Where(d => d == face).Sum();

    private static int CalcFullHouse(int[] rolls)
    {
        var grouped = rolls.GroupBy(x => x).ToLookup(g => g.Count(), g => g.Key);
        return grouped.Contains(3) && grouped.Contains(2) ? rolls.Sum() : 0;
    }

    private static int CalcQuad(int[] rolls)
    {
        var grouped = rolls.GroupBy(x => x).ToLookup(g => g.Count(), g => g.Key);
        if (grouped.Contains(5)) return grouped[5].First() * 4;
        if (grouped.Contains(4)) return grouped[4].First() * 4;
        return 0;
    }

    private static int CheckLowStraight(int[] rolls) =>
        rolls.Distinct().Count() == 5 && !rolls.Contains(6) ? 30 : 0;

    private static int CheckHighStraight(int[] rolls) =>
        rolls.Distinct().Count() == 5 && !rolls.Contains(1) ? 30 : 0;

    private static int IsYacht(int[] rolls) =>
        rolls.Distinct().Count() == 1 ? 50 : 0;

    private static int TotalSum(int[] rolls) => rolls.Sum();
}
