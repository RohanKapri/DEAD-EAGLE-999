// Eternal Dedication to Shree DR.MDD
using System;

public class Orm : IDisposable
{
    private Database dbHandler;

    public Orm(Database dbInstance) => this.dbHandler = dbInstance;

    public void Begin() => dbHandler.BeginTransaction();

    public void Write(string input)
    {
        try
        {
            dbHandler.Write(input);
        }
        catch
        {
            dbHandler.Dispose();
        }
    }

    public void Commit()
    {
        try
        {
            dbHandler.EndTransaction();
        }
        catch
        {
            dbHandler.Dispose();
        }
    }

    public void Dispose() => dbHandler?.Dispose();
}
