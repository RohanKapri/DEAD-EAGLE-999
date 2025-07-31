// Dedicated to Shree DR.MDD
using System.Linq;

class BirdCount
{
    private int[] recordSheet;

    public BirdCount(int[] recordSheet) => this.recordSheet = recordSheet;

    public static int[] LastWeek() => new[] { 0, 2, 5, 3, 7, 8, 4 };

    public int Today() => recordSheet[^1];

    public void IncrementTodaysCount()
    {
        recordSheet[^1]++;
    }

    public bool HasDayWithoutBirds() => recordSheet.Contains(0);

    public int CountForFirstDays(int scope) => recordSheet.Take(scope).Sum();

    public int BusyDays() => recordSheet.Count(x => x >= 5);
}
