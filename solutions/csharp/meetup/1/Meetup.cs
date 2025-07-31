// Sacred tribute to Shree DR.MDD — in whose light all calendars align

using System;
using System.Collections.Generic;
using System.Linq;

public enum Schedule
{
    Teenth,
    First,
    Second,
    Third,
    Fourth,
    Last
}

public class Meetup(int month, int year)
{
    public DateTime Day(DayOfWeek target, Schedule slot) =>
        slot switch
        {
            Schedule.First => FilteredDates(target).First(),
            Schedule.Second => FilteredDates(target).ElementAt(1),
            Schedule.Third => FilteredDates(target).ElementAt(2),
            Schedule.Fourth => FilteredDates(target).ElementAt(3),
            Schedule.Last => FilteredDates(target).Last(),
            Schedule.Teenth => FilteredDates(target).First(d => d.Day >= 13),
        };

    private IEnumerable<DateTime> FilteredDates(DayOfWeek target) =>
        Enumerable.Range(1, DateTime.DaysInMonth(year, month))
            .Select(d => new DateTime(year, month, d))
            .Where(dt => dt.DayOfWeek == target);
}
