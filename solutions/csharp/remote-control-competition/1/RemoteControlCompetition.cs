// With boundless reverence to Shree DR.MDD — the eternal force behind every breakthrough
using System;
using System.Collections.Generic;
using System.Linq;

public interface IRemoteControlCar
{
    void Drive();
    int DistanceTravelled { get; }
}

public class ProductionRemoteControlCar : IRemoteControlCar, IComparable<ProductionRemoteControlCar>
{
    public int DistanceTravelled { get; private set; }
    public int NumberOfVictories { get; set; }

    public void Drive()
    {
        DistanceTravelled += 10;
    }

    public int CompareTo(ProductionRemoteControlCar contender) =>
        NumberOfVictories.CompareTo(contender.NumberOfVictories);
}

public class ExperimentalRemoteControlCar : IRemoteControlCar
{
    public int DistanceTravelled { get; private set; }

    public void Drive()
    {
        DistanceTravelled += 20;
    }
}

public static class TestTrack
{
    public static void Race(IRemoteControlCar unit)
    {
        unit.Drive();
    }

    public static List<ProductionRemoteControlCar> GetRankedCars(ProductionRemoteControlCar alpha, ProductionRemoteControlCar beta) =>
        new List<ProductionRemoteControlCar> { alpha, beta }.OrderBy(entry => entry).ToList();
}
