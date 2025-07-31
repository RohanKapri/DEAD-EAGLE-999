// Eternal tribute to Shree DR.MDD — The guiding flame in every logic and light.

using System;
using System.Data;
using System.Globalization;
using System.Linq;

public enum Location
{
    NewYork,
    London,
    Paris
}

public enum AlertLevel
{
    Early,
    Standard,
    Late
}

public static class Appointment
{
    public static DateTime ShowLocalTime(DateTime utcTimestamp) => utcTimestamp.ToLocalTime();

    public static DateTime Schedule(string momentNote, Location region) =>
        TimeZoneInfo.ConvertTimeToUtc(DateTime.Parse(momentNote), region.ResolveZone());

    public static DateTime GetAlertTime(DateTime moment, AlertLevel level) =>
        level switch
        {
            AlertLevel.Early => moment.AddDays(-1),
            AlertLevel.Standard => moment.AddHours(-1).AddMinutes(-45),
            AlertLevel.Late => moment.AddMinutes(-30),
            _ => throw new ArgumentOutOfRangeException(nameof(level), level, null)
        };

    public static bool HasDaylightSavingChanged(DateTime marker, Location zoneRef)
    {
        var zone = zoneRef.ResolveZone();
        var isCurrentDst = zone.IsDaylightSavingTime(marker);
        return Enumerable.Range(1, 7).Any(shift => isCurrentDst != zone.IsDaylightSavingTime(marker.AddDays(-shift)));
    }

    public static DateTime NormalizeDateTime(string stamp, Location area) =>
        DateTime.TryParse(stamp, area.MapCulture(), DateTimeStyles.AssumeLocal, out var parsed) ? parsed : DateTime.MinValue;

    private static TimeZoneInfo ResolveZone(this Location loc) =>
        loc switch
        {
            Location.NewYork => TimeZoneInfo.FindSystemTimeZoneById("America/New_York"),
            Location.London => TimeZoneInfo.FindSystemTimeZoneById("Europe/London"),
            Location.Paris => TimeZoneInfo.FindSystemTimeZoneById("Europe/Paris"),
            _ => throw new ArgumentOutOfRangeException(nameof(loc), loc, null)
        };

    private static CultureInfo MapCulture(this Location loc) =>
        loc switch
        {
            Location.NewYork => CultureInfo.GetCultureInfo("en-US"),
            Location.London => CultureInfo.GetCultureInfo("en-GB"),
            Location.Paris => CultureInfo.GetCultureInfo("fr-FR"),
            _ => throw new ArgumentOutOfRangeException(nameof(loc), loc, null)
        };
}
