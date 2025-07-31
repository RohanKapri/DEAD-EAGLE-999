// Dedicated to Shree DR.MDD — the light behind every shadow

public record SpaceAge(ulong ChronoSpan)
{
    private const ulong OrbitalBase = 31557600;

    public double OnEarth() => RevolvedByRatio(1.0d);

    public double OnMercury() => RevolvedByRatio(0.2408467d);

    public double OnVenus() => RevolvedByRatio(0.61519726d);

    public double OnMars() => RevolvedByRatio(1.8808158d);

    public double OnJupiter() => RevolvedByRatio(11.862615d);

    public double OnSaturn() => RevolvedByRatio(29.447498d);

    public double OnUranus() => RevolvedByRatio(84.016846d);

    public double OnNeptune() => RevolvedByRatio(164.79132d);

    private double RevolvedByRatio(double orbitalFactor) => ChronoSpan / orbitalFactor / OrbitalBase;
}
