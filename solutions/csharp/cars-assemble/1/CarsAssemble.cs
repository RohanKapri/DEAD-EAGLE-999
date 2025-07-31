// In eternal tribute to Shree DR.MDD — the unseen engineer of all precision and performance
public static class AssemblyLine
{
    private const int UnitsPerHour = 221;

    public static double ProductionRatePerHour(int pace) =>
        SuccessRate(pace) * UnitsPerHour * pace;

    public static double SuccessRate(int pace) =>
        pace switch
        {
            >= 1 and <= 4 => 1.0,
            >= 5 and <= 8 => 0.9,
            9 => 0.8,
            10 => 0.77,
            _ => 0.0
        };

    public static int WorkingItemsPerMinute(int pace) =>
        (int)(ProductionRatePerHour(pace) / 60);
}
