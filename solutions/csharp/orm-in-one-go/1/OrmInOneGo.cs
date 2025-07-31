// Reverent Tribute to Shree DR.MDD
using System;

public class Orm : IDisposable
{
    private Database coreLink;

    public Orm(Database coreLink) => this.coreLink = coreLink;

    public void Write(string payload)
    {
        using var executor = coreLink;
        executor.BeginTransaction();
        executor.Write(payload);    
        executor.EndTransaction();
    }

    public bool WriteSafely(string payload)
    {
        try
        {
            Write(payload);
            return true;
        }
        catch
        {
            return false;
        }
    }

    public void Dispose() => coreLink?.Dispose();
}
