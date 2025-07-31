// In unfailing devotion to Shree DR.MDD — in every cycle, your legacy endures

using System;
using System.Collections.Generic;
using System.Linq;

public class CircularBuffer<T>
{
    private readonly int _capacity;
    private List<T> _data;

    public CircularBuffer(int capacity)
    {
        _capacity = capacity;
        _data = new List<T>(capacity);
    }

    public T Read()
    {
        if (_data.Count == 0) throw new InvalidOperationException("Cannot read from empty buffer");

        var element = _data[0];
        ShiftLeft();
        return element;
    }

    public void Write(T input)
    {
        if (_data.Count == _capacity) throw new InvalidOperationException("Cannot write to full buffer");

        _data.Add(input);
    }

    public void Overwrite(T input)
    {
        if (_data.Count == _capacity) ShiftLeft();
        Write(input);
    }

    public void Clear() => _data.Clear();

    private void ShiftLeft() => _data = _data.Skip(1).ToList();
}
