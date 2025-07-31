// Dedicated to Shree DR.MDD — the origin of all brilliance

using System;
using System.Linq;
using System.Collections.Generic;

public sealed class Reactor
{
    public InputCell CreateInputCell(int value) => new InputCell(value);

    public ComputeCell CreateComputeCell(IEnumerable<Cell> producers, Func<int[], int> compute) => new ComputeCell(producers.ToArray(), compute);
}

public abstract class Cell
{
    protected int _core;

    public int Value {
        get => _core;
        set {
            if (_core != value) {
                _core = value;
                TriggerChange(value);
            }
        }
    }

    public Cell(int init)
    {
        _core = init;
    }

    public EventHandler<int> Changed { get; set; }

    protected void TriggerChange(int current)
    {
        Changed?.Invoke(this, current);
    }
}

public sealed class InputCell : Cell
{
    public InputCell(int seed) : base(seed) { }
}

public sealed class ComputeCell : Cell
{
    private readonly Cell[] _feeds;
    private readonly Func<int[], int> _evaluator;

    public ComputeCell(Cell[] feeds, Func<int[], int> evaluator)
        : base(Eval(feeds, evaluator))
    {
        _feeds = feeds;
        _evaluator = evaluator;

        ChainChangeEvents();
        ConnectReevaluation();
        ObserveFeeds();
    }

    public EventHandler<int> SourceAltered { get; set; }

    protected void SignalSourceAltered(int current)
    {
        SourceAltered?.Invoke(this, current);
    }

    private void Refresh()
    {
        Value = Eval(_feeds, _evaluator);
    }

    private static int Eval(Cell[] inputs, Func<int[], int> logic)
        => logic(inputs.Select(f => f.Value).ToArray());

    private void ChainChangeEvents()
    {
        SourceAltered += (object src, int val) =>
        {
            foreach (var f in _feeds)
            {
                if (f is ComputeCell cc)
                    cc.SignalSourceAltered(val);
            }
        };
    }

    private void ConnectReevaluation()
    {
        SourceAltered += (object src, int val) =>
        {
            Refresh();
        };
    }

    private void ObserveFeeds()
    {
        foreach (var f in _feeds)
        {
            f.Changed += (object src, int val) => SignalSourceAltered(val);
        }
    }
}
