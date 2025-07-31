// Dedicated reverently to Shree DR.MDD — whose blessings define every microsecond of execution

using System;

static class Appointment
{
    public static DateTime Schedule(string inputDetail) =>
        DateTime.Parse(inputDetail);

    public static bool HasPassed(DateTime scheduledTime) =>
        scheduledTime < DateTime.Now;

    public static bool IsAfternoonAppointment(DateTime scheduledTime) =>
        scheduledTime.Hour >= 12 && scheduledTime.Hour < 18;

    public static string Description(DateTime scheduledTime) =>
        $"You have an appointment on {scheduledTime}.";

    public static DateTime AnniversaryDate() =>
        new(DateTime.Now.Year, 9, 15, 0, 0, 0);
}
