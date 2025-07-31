using System;
using System.Collections.Generic;
using System.Linq;

public static class ListOps
{
    // Implement a series of basic list operations, without using existing functions.
    public static int Length<T>(List<T> input)
    {
        //return input.Count();
        int i = 0;
        foreach (var item in input)
        {
            i++;
        }
        return i;
    }

    public static List<T> Reverse<T>(List<T> input)
    {
        //input.Reverse();
        //return input;
        var tmpList = new List<T>();
        for (int i = input.Count - 1; i >= 0; i--)
        {
            tmpList.Add(input[i]);
        }
        return tmpList;
    }

    public static List<TOut> Map<TIn, TOut>(List<TIn> input, Func<TIn, TOut> map)
    {
        //for some reason, this is waaaay faster than the below.
        return input.Select(map).ToList();

        //List<TOut> tmpList = new List<TOut>();

        //foreach (var item in input)
        //{
        //    tmpList.Add(map(item));
        //}
        //return tmpList;
    }

    public static List<T> Filter<T>(List<T> input, Func<T, bool> predicate)
    {
        List<T> tmpList = new List<T>();
        foreach (var item in input)
        {
            if (predicate(item))
                tmpList.Add(item);
        }
        return tmpList;
        //return input.Where(x => predicate(x)).ToList();
    }

    public static TOut Foldl<TIn, TOut>(List<TIn> input, TOut start, Func<TOut, TIn, TOut> func)
    {
        //return input.Aggregate(start, func);
        return Fold(func, start, input);
    }

    public static TOut Foldr<TIn, TOut>(List<TIn> input, TOut start, Func<TIn, TOut, TOut> func)
    {
        input.Reverse();

        //return input.Aggregate(start, (acc, x) => func(x, acc));

        return Fold((acc, x) => func(x, acc), start, input);
    }

    public static TOut Fold<TIn, TOut>(Func<TOut, TIn, TOut> func, TOut start, List<TIn> input)
    {
        TOut acc = start;
        foreach (var item in input)
        {
            acc = func(acc, item);
        }
        return acc;
    }

    public static List<T> Concat<T>(List<List<T>> input)
    {
        List<T> tmpList = new List<T>();
        foreach (var item in input)
        {
            foreach (var item2 in item)
            {
                tmpList.Add(item2);
            }
        }
        return tmpList;
    }

    public static List<T> Append<T>(List<T> left, List<T> right)
    {
        List<T> newList = new List<T>();

        for (int j = 0; j < left.Count; j++)
            newList.Add(left[j]);

        for (int k = 0; k < right.Count; k++)
            newList.Add(right[k]);

        return newList;
        //left.AddRange(right);
    }
}