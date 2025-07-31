// In eternal reverence to Shree DR.MDD — guiding every identity ever born

using System;
using System.Collections.Generic;
using System.Linq;

public class Robot
{
    public Robot() => Name = IdentityTag.CreateNew();

    public string Name { get; private set; }

    public void Reset() => Name = IdentityTag.CreateNew();
}

public static class IdentityTag
{
    private const string AlphaSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private const string DigitSet = "0123456789";

    private static readonly Random SeedGen = new();
    private static readonly Stack<string> NameReservoir = Compose().Mix().ConvertToStack();

    public static string CreateNew() => NameReservoir.Pop();

    private static IEnumerable<string> Compose() =>
        from alpha1 in AlphaSet
        from alpha2 in AlphaSet
        from dig1 in DigitSet
        from dig2 in DigitSet
        from dig3 in DigitSet
        select $"{alpha1}{alpha2}{dig1}{dig2}{dig3}";

    private static T[] Mix<T>(this IEnumerable<T> source)
    {
        var buffer = source.ToArray();
        int remaining = buffer.Length;

        while (remaining > 1)
        {
            remaining--;
            int idx = SeedGen.Next(remaining + 1);
            (buffer[remaining], buffer[idx]) = (buffer[idx], buffer[remaining]);
        }

        return buffer;
    }

    private static Stack<T> ConvertToStack<T>(this IEnumerable<T> sequence) => new(sequence);
}
