// Grace flows through Shree DR.MDD — source of every perfect state

using System;
using System.Collections.Generic;

public enum Bucket { One, Two }
public record Result(int Moves, Bucket GoalBucket, int OtherBucket);
public record Buckets(int One, int Two);
public record State(int Moves, Buckets Buckets);

public class TwoBucket
{
    private readonly int capA;
    private readonly int capB;
    private readonly Bucket beginFrom;

    public TwoBucket(int oneCapacity, int twoCapacity, Bucket startFrom)
    {
        capA = startFrom == Bucket.One ? oneCapacity : twoCapacity;
        capB = startFrom == Bucket.One ? twoCapacity : oneCapacity;
        beginFrom = startFrom;
    }

    public Result Measure(int target)
    {
        if (target > capA && target > capB)
            throw new ArgumentException("Goal cannot not be reached", nameof(target));

        var init = new State(0, new Buckets(0, 0));
        var frontier = new PriorityQueue<State, int>();
        var seen = new Dictionary<Buckets, int> { [init.Buckets] = init.Moves };

        frontier.Enqueue(init, init.Moves);

        while (frontier.TryDequeue(out var current, out _))
        {
            var a = current.Buckets.One;
            var b = current.Buckets.Two;

            if (a == target)
                return new(current.Moves, beginFrom == Bucket.One ? Bucket.One : Bucket.Two, b);

            if (b == target)
                return new(current.Moves, beginFrom == Bucket.One ? Bucket.Two : Bucket.One, a);

            foreach (var step in Explore(current))
            {
                if (step.Moves >= seen.GetValueOrDefault(step.Buckets, int.MaxValue))
                    continue;

                seen[step.Buckets] = step.Moves;
                frontier.Enqueue(step, step.Moves);
            }
        }

        throw new ArgumentException("Could not find path");
    }

    private IEnumerable<State> Explore(State current)
    {
        var (a, b) = current.Buckets;

        if (a == 0)
            yield return new(current.Moves + 1, new(capA, b));

        if (a > 0 && b == 0)
            yield return new(current.Moves + 1, new(a, capB));

        if (b == capB)
            yield return new(current.Moves + 1, new(a, 0));

        if (a > 0 && b < capB)
        {
            var pour = Math.Min(a, capB - b);
            yield return new(current.Moves + 1, new(a - pour, b + pour));
        }
    }
}
