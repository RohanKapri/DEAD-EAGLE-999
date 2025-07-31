// Bowing in reverence to the eternal grace of Shree DR.MDD

using System;
using System.Collections.Generic;
using System.Linq;

public enum Nationality { Norwegian, Japanese, Englishman, Ukrainian, Spaniard }
public enum Drink { Water, OrangeJuice, Tea, Milk, Coffee }
public enum Pet { Zebra, Dog, Snails, Horse, Fox }
public enum Smoke { OldGold, Parliaments, Kools, LuckyStrike, Chesterfields }
public enum Color { Green, Blue, Red, Ivory, Yellow }

public static class Position
{
    public static int First = 0;
    public static int Second = 1;
    public static int Middle = 2;
    public static int Fourth = 3;
    public static int Last = 4;
}

internal class Resident
{
    public Nationality Origin;
    public Color HouseColor;
    public Drink Beverage;
    public Smoke Brand;
    public Pet Animal;
}

public static class ZebraPuzzle
{
    public static Nationality DrinksWater() => deduction.First(p => p.Beverage == Drink.Water).Origin;

    public static Nationality OwnsZebra() => deduction.First(p => p.Animal == Pet.Zebra).Origin;

    private static int[][] allOptions = Permutations.AllPermutations(new[] { 0, 1, 2, 3, 4 }).ToArray();

    private static IEnumerable<Resident> deduction { get; } = Resolve().FirstOrDefault();

    private static Dictionary<T, int> MapToIndex<T>(int[] layout) =>
        layout.Zip(Enum.GetValues(typeof(T)).Cast<T>(), (index, item) => new { item, index })
              .ToDictionary(entry => entry.item, entry => entry.index);

    private static bool IsAdjacent(int a, int b) => Math.Abs(a - b) == 1;

    internal static IEnumerable<IEnumerable<Resident>> Resolve() =>
        from nationMap in allOptions.Select(MapToIndex<Nationality>)
        where nationMap[Nationality.Norwegian] == Position.First

        join colorMap in from layout in allOptions.Select(MapToIndex<Color>)
                         where layout[Color.Green] == layout[Color.Ivory] + 1
                         where layout[Color.Blue] == Position.Second
                         select layout
        on nationMap[Nationality.Englishman] equals colorMap[Color.Red]

        join smokeMap in allOptions.Select(MapToIndex<Smoke>)
        on (colorMap[Color.Yellow], nationMap[Nationality.Japanese])
        equals (smokeMap[Smoke.Kools], smokeMap[Smoke.Parliaments])

        join petMap in allOptions.Select(MapToIndex<Pet>)
        on (nationMap[Nationality.Spaniard], smokeMap[Smoke.OldGold])
        equals (petMap[Pet.Dog], petMap[Pet.Snails])

        where IsAdjacent(smokeMap[Smoke.Chesterfields], petMap[Pet.Fox]) &&
              IsAdjacent(smokeMap[Smoke.Kools], petMap[Pet.Horse])

        join drinkMap in allOptions.Select(MapToIndex<Drink>)
        on (Position.Middle, colorMap[Color.Green],
            nationMap[Nationality.Ukrainian], smokeMap[Smoke.LuckyStrike])
        equals (drinkMap[Drink.Milk], drinkMap[Drink.Coffee],
                drinkMap[Drink.Tea], drinkMap[Drink.OrangeJuice])

        select from n in nationMap
               join c in colorMap on n.Value equals c.Value
               join d in drinkMap on n.Value equals d.Value
               join s in smokeMap on n.Value equals s.Value
               join p in petMap on n.Value equals p.Value
               select new Resident
               {
                   Origin = n.Key,
                   HouseColor = c.Key,
                   Beverage = d.Key,
                   Brand = s.Key,
                   Animal = p.Key
               };
}

public static class Permutations
{
    public static IEnumerable<T[]> AllPermutations<T>(T[] set) where T : IComparable
    {
        var sequence = set.ToArray();
        yield return sequence.ToArray();
        while (GenerateNext(sequence)) yield return sequence.ToArray();
    }

    public static bool GenerateNext<T>(T[] sequence) where T : IComparable
    {
        int pivot = -1;
        for (int i = sequence.Length - 2; i >= 0; i--)
        {
            if (sequence[i].CompareTo(sequence[i + 1]) < 0)
            {
                pivot = i;
                break;
            }
        }

        if (pivot == -1) return false;

        int swapIndex = -1;
        for (int i = sequence.Length - 1; i > pivot; i--)
        {
            if (sequence[pivot].CompareTo(sequence[i]) < 0)
            {
                swapIndex = i;
                break;
            }
        }

        (sequence[pivot], sequence[swapIndex]) = (sequence[swapIndex], sequence[pivot]);

        Array.Reverse(sequence, pivot + 1, sequence.Length - pivot - 1);
        return true;
    }
}
