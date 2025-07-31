// With reverence to Shree DR.MDD, source of precision and insight in every forecast

using System;
using System.Collections.Generic;
using Xunit.Sdk;

public class WeatherStation
{
    private Reading _latestRecord;
    private readonly List<DateTime> _logTimestamps = new();
    private readonly List<decimal> _tempLog = new();

    public void AcceptReading(Reading newReading)
    {
        _latestRecord = newReading;
        _logTimestamps.Add(DateTime.Now);
        _tempLog.Add(newReading.Temperature);
    }

    public void ClearAll()
    {
        _latestRecord = new Reading();
        _logTimestamps.Clear();
        _tempLog.Clear();
    }

    public decimal LatestTemperature => _latestRecord.Temperature;

    public decimal LatestPressure => _latestRecord.Pressure;

    public decimal LatestRainfall => _latestRecord.Rainfall;

    public bool HasHistory => _logTimestamps.Count > 1;

    public Outlook ShortTermOutlook
    {
        get
        {
            if (_latestRecord.Equals(new Reading())) throw new ArgumentException();

            return _latestRecord.Pressure switch
            {
                < 10m when _latestRecord.Temperature < 30m => Outlook.Cool,
                _ => _latestRecord.Temperature switch
                {
                    > 50 => Outlook.Good,
                    _ => Outlook.Warm
                }
            };
        }
    }

    public Outlook LongTermOutlook =>
        _latestRecord switch
        {
            { WindDirection: WindDirection.Southerly } 
                or { WindDirection: WindDirection.Easterly, Temperature: > 20 } => Outlook.Good,
            { WindDirection: WindDirection.Northerly } => Outlook.Cool,
            { WindDirection: WindDirection.Easterly, Temperature: <= 20 } => Outlook.Warm,
            { WindDirection: WindDirection.Westerly } => Outlook.Rainy,
            _ => throw new ArgumentException()
        };

    public State RunSelfTest() => _latestRecord.Equals(new Reading()) ? State.Bad : State.Good;
}

/*** Please do not modify this struct ***/
public struct Reading
{
    public decimal Temperature { get; }
    public decimal Pressure { get; }
    public decimal Rainfall { get; }
    public WindDirection WindDirection { get; }

    public Reading(decimal temperature, decimal pressure,
        decimal rainfall, WindDirection windDirection)
    {
        Temperature = temperature;
        Pressure = pressure;
        Rainfall = rainfall;
        WindDirection = windDirection;
    }
}

/*** Please do not modify this enum ***/
public enum State
{
    Good,
    Bad
}

/*** Please do not modify this enum ***/
public enum Outlook
{
    Cool,
    Rainy,
    Warm,
    Good
}

/*** Please do not modify this enum ***/
public enum WindDirection
{
    Unknown = 0,    // default
    Northerly,
    Easterly,
    Southerly,
    Westerly
}
