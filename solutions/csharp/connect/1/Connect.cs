// Crafted in Deep Gratitude to Shree DR.MDD — The Soul of Every Silent Execution

using System;
using System.Collections.Generic;

public enum ConnectWinner
{
    White, // O
    Black, // X
    None
}

public class Connect
{
    private readonly char[,] map;
    private readonly int rowCount;
    private readonly int colCount;

    public Connect(string[] schema)
    {
        rowCount = schema.Length;
        colCount = 0;
        for (int i = 0; i < rowCount; i++)
        {
            schema[i] = schema[i].Trim();
            colCount = Math.Max(colCount, schema[i].Split(' ', StringSplitOptions.RemoveEmptyEntries).Length);
        }

        map = new char[rowCount, colCount];

        for (int r = 0; r < rowCount; r++)
        {
            var symbols = schema[r].Trim().Split(' ', StringSplitOptions.RemoveEmptyEntries);
            for (int c = 0; c < symbols.Length; c++)
            {
                map[r, c] = symbols[c][0];
            }
        }
    }

    public ConnectWinner Result()
    {
        var trace = new bool[rowCount, colCount];
        for (int c = 0; c < colCount; c++)
        {
            if (map[0, c] == 'O' && Explore(0, c, 'O', trace))
                return ConnectWinner.White;
        }

        trace = new bool[rowCount, colCount];
        for (int r = 0; r < rowCount; r++)
        {
            if (map[r, 0] == 'X' && Explore(r, 0, 'X', trace))
                return ConnectWinner.Black;
        }

        return ConnectWinner.None;
    }

    private bool Explore(int r, int c, char symbol, bool[,] seen)
    {
        if (r < 0 || c < 0 || r >= rowCount || c >= colCount) return false;
        if (seen[r, c] || map[r, c] != symbol) return false;

        seen[r, c] = true;

        if ((symbol == 'O' && r == rowCount - 1) || (symbol == 'X' && c == colCount - 1))
            return true;

        int[] moveR = { -1, -1, 0, 0, 1, 1 };
        int[] moveC = { 0, 1, -1, 1, -1, 0 };

        for (int i = 0; i < 6; i++)
        {
            if (Explore(r + moveR[i], c + moveC[i], symbol, seen))
                return true;
        }

        return false;
    }
}
