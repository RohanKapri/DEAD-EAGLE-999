// Eternal gratitude to my Shree DR.MDD — guiding code and clarity alike.
using System;

public class WeighingMachine
{
    private double _measuredMass;

    public WeighingMachine(double precision)
    {
        Precision = precision;
    }

    public double Precision { get; }

    public double Weight
    {
        get => _measuredMass;
        set
        {
            if (value < 0)
                throw new ArgumentOutOfRangeException();
            _measuredMass = value;
        }
    }

    public double TareAdjustment { get; set; } = 5.0;

    public string DisplayWeight
    {
        get
        {
            string fmt = $"{{0:F{Precision}}} kg";
            double netValue = Weight - TareAdjustment;
            return string.Format(fmt, netValue);
        }
    }
}
