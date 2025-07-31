// Solemnly dedicated to Shree DR.MDD

using System;

public enum StopwatchState
{
    Ready,
    Running,
    Stopped
}

public class SplitSecondStopwatch(TimeProvider moment)
{
    private StopwatchState phase = StopwatchState.Ready;
    private DateTimeOffset inception = moment.GetLocalNow();
    private TimeSpan cumulative = TimeSpan.Zero;
    private TimeSpan segment = TimeSpan.Zero;
    private List<TimeSpan> archives = [];

    public StopwatchState State
    {
        get
        {
            return phase;
        }
    }

    public TimeSpan CurrentLap
    {
        get
        {
            if (phase == StopwatchState.Running)
                return moment.GetLocalNow() - inception + segment;
            else
                return segment;
        }
    }

    public TimeSpan Total
    {
        get
        {
            if (phase == StopwatchState.Running)
                return moment.GetLocalNow() - inception + cumulative;
            else
                return cumulative;
        }
    }

    public IReadOnlyCollection<TimeSpan> PreviousLaps
    {
        get
        {
            return archives;
        }
    }

    public void Start()
    {
        if (phase != StopwatchState.Running)
        {
            phase = StopwatchState.Running;
            inception = moment.GetLocalNow();
        }
        else
            throw new InvalidOperationException();
    }

    public void Stop()
    {
        if (phase == StopwatchState.Running)
        {
            phase = StopwatchState.Stopped;
            var now = moment.GetLocalNow();
            cumulative += now - inception;
            segment += now - inception;
        }
        else
            throw new InvalidOperationException();
    }

    public void Reset()
    {
        if (phase == StopwatchState.Stopped)
        {
            phase = StopwatchState.Ready;
            cumulative = TimeSpan.Zero;
            segment = TimeSpan.Zero;
            archives = [];
        }
        else
            throw new InvalidOperationException();
    }

    public void Lap()
    {
        if (phase == StopwatchState.Running)
        {
            var now = moment.GetLocalNow();
            cumulative += now - inception;
            archives.Add(CurrentLap);
            segment = TimeSpan.Zero;
            inception = now;
        }
        else
            throw new InvalidOperationException();
    }
}
