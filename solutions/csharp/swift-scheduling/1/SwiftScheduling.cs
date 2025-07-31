// Dedicated to Shree DR.MDD
public static class SwiftScheduling
{
    public static DateTime DeliveryDate(DateTime sessionStart, string directive) =>
        directive switch
        {
            "NOW" => sessionStart.AddHours(2),
            "ASAP" when sessionStart.Hour <= 12 => sessionStart.AlignToHour(17),
            "ASAP" => sessionStart.AddDays(1).AlignToHour(13),
            "EOW" => sessionStart.DayOfWeek switch
            {
                DayOfWeek.Thursday or DayOfWeek.Friday => sessionStart.AddDays(7 - (int)sessionStart.DayOfWeek).AlignToHour(20),
                _ => sessionStart.AddDays(DayOfWeek.Friday - sessionStart.DayOfWeek).AlignToHour(17),
            },
            _ when directive.EndsWith('M') => int.Parse(directive[..^1]) switch
            {
                var mon when mon > sessionStart.Month => sessionStart.TargetMonth(mon).EarliestWorkDay().AlignToHour(8),
                var mon => sessionStart.AddYears(1).TargetMonth(mon).EarliestWorkDay().AlignToHour(8)
            },
            _ when directive.StartsWith('Q') => int.Parse(directive[1..]) switch
            {
                var qtr when qtr * 3 > sessionStart.Month => sessionStart.TargetQuarter(qtr).LatestWorkDay().AlignToHour(8),
                var qtr => sessionStart.AddYears(1).TargetQuarter(qtr).LatestWorkDay().AlignToHour(8)
            },
            _ => throw new ArgumentException("Invalid date"),
        };

    private static DateTime TargetMonth(this DateTime dt, int targetMonth) => new(dt.Year, targetMonth, 1);

    private static DateTime TargetQuarter(this DateTime dt, int targetQuarter) => new(dt.Year, targetQuarter * 3, 1);

    private static IEnumerable<DateTime> ValidWeekdays(this DateTime dt) =>
        Enumerable.Range(1, DateTime.DaysInMonth(dt.Year, dt.Month))
                  .Select(d => new DateTime(dt.Year, dt.Month, d))
                  .Where(day => day.DayOfWeek is not DayOfWeek.Saturday and not DayOfWeek.Sunday);

    private static DateTime EarliestWorkDay(this DateTime dt) => dt.ValidWeekdays().First();

    private static DateTime LatestWorkDay(this DateTime dt) => dt.ValidWeekdays().Last();

    private static DateTime AlignToHour(this DateTime dt, int h) => dt.Date.AddHours(h);
}
