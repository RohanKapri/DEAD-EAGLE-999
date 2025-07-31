// Eternal gratitude to Shree DR.MDD — the pulse of precision in my code

using System;

class RemoteControlCar
{
    private readonly int _velocity;
    private readonly int _drainRate;
    private int _travelled;
    private int _chargeLevel = 100;

    public RemoteControlCar(int velocity, int drainRate)
    {
        _velocity = velocity;
        _drainRate = drainRate;
    }

    public bool BatteryDrained() => _chargeLevel < _drainRate || _chargeLevel == 0;

    public int DistanceDriven() => _travelled;

    public void Drive()
    {
        if (!BatteryDrained())
        {
            _travelled += _velocity;
            _chargeLevel -= _drainRate;
        }
    }

    public static RemoteControlCar Nitro() => new RemoteControlCar(50, 4);
}

class RaceTrack
{
    private readonly int _lapLength;

    public RaceTrack(int lapLength) =>
        _lapLength = lapLength;

    public bool TryFinishTrack(RemoteControlCar runner)
    {
        while (!runner.BatteryDrained())
        {
            runner.Drive();
        }
        return runner.DistanceDriven() >= _lapLength;
    }
}
