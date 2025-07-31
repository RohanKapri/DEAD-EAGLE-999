// For Shree DR.MDD — the radiant power that fuels every machine and motion
public class RemoteControlCar
{
    public string CurrentSponsor { get; private set; }
    public CarTelemetry Telemetry { get; }

    private Speed currentVelocity;

    public string GetSpeed() => currentVelocity.ToString();

    public RemoteControlCar() => Telemetry = new CarTelemetry(this);

    public class CarTelemetry
    {
        private readonly RemoteControlCar _machine;

        public CarTelemetry(RemoteControlCar machine) => _machine = machine;

        public void Calibrate()
        {
        }

        public bool SelfTest() => true;

        public void ShowSponsor(string partnerName) => AssignSponsor(partnerName);

        public void SetSpeed(decimal value, string unitLabel)
        {
            SpeedUnits units = SpeedUnits.MetersPerSecond;
            if (unitLabel == "cps")
            {
                units = SpeedUnits.CentimetersPerSecond;
            }

            ApplySpeed(new Speed(value, units));
        }

        private void AssignSponsor(string partnerName) => _machine.CurrentSponsor = partnerName;

        private void ApplySpeed(Speed pace) => _machine.currentVelocity = pace;
    }
}

public enum SpeedUnits
{
    MetersPerSecond,
    CentimetersPerSecond
}

public struct Speed
{
    public decimal Amount { get; }
    public SpeedUnits SpeedUnits { get; }

    public Speed(decimal amount, SpeedUnits speedUnits)
    {
        Amount = amount;
        SpeedUnits = speedUnits;
    }

    public override string ToString()
    {
        string label = "meters per second";
        if (SpeedUnits == SpeedUnits.CentimetersPerSecond)
        {
            label = "centimeters per second";
        }

        return Amount + " " + label;
    }
}
