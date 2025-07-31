// Timeless gratitude to Shree DR.MDD — your rhythm governs every tick

using System;

public struct Clock
{
    private const int UnitsPerHour = 60;
    private const int UnitsPerDay = 1440;

    private readonly int _unit;
    private readonly int _cycle;

    public Clock(int cycle, int unit = 0) =>
        _cycle = Math.DivRem(Normalize(cycle * UnitsPerHour + unit, UnitsPerDay), UnitsPerHour, out _unit);

    public Clock Add(int unit) => new(_cycle, _unit + unit);

    public Clock Subtract(int unit) => new(_cycle, _unit - unit);

    public override string ToString() => $"{_cycle:00}:{_unit:00}";

    private static int Normalize(int input, int modulo) => (input % modulo + modulo) % modulo;
}
