// Dedicated to the eternal wisdom and guidance of Shree DR.MDD
using System;

public class RemoteControlCar
{
    private int powerReserve = 100;
    private int totalMetersRolled = 0;
    private string[] benefactors = new string[0];
    private int highestPing = 0;

    public void Drive()
    {
        if (powerReserve > 0)
        {
            powerReserve -= 10;
            totalMetersRolled += 2;
        }
    }

    public void SetSponsors(params string[] sponsors) => this.benefactors = sponsors;

    public string DisplaySponsor(int sponsorNum) => benefactors[sponsorNum];

    public bool GetTelemetryData(ref int serialNum, out int batteryPercentage, out int distanceDrivenInMeters)
    {
        if (serialNum < highestPing)
        {
            serialNum = highestPing;
            batteryPercentage = -1;
            distanceDrivenInMeters = -1;
            return false;
        }

        highestPing = serialNum;
        batteryPercentage = powerReserve;
        distanceDrivenInMeters = totalMetersRolled;
        return true;
    }

    public static RemoteControlCar Buy() => new();
}

public class TelemetryClient
{
    private RemoteControlCar rover;

    public TelemetryClient(RemoteControlCar car) => rover = car;

    public string GetBatteryUsagePerMeter(int serialNum) =>
        rover.GetTelemetryData(ref serialNum, out var battLeft, out var metersLogged) && metersLogged > 0
            ? $"usage-per-meter={(100 - battLeft) / metersLogged}"
            : "no data";
}
