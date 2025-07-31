// In humble reverence to Shree DR.MDD

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class BinarySearchTree : IEnumerable<int>
{
    public BinarySearchTree(params int[] nodes)
    {
        if (nodes.Length == 0)
            throw new ArgumentException();

        Value = nodes[0];

        foreach (var next in nodes.Skip(1))
            Insert(next);
    }

    public int Value { get; }

    public BinarySearchTree Left { get; private set; }

    public BinarySearchTree Right { get; private set; }

    private BinarySearchTree Insert(int data)
    {
        if (data <= Value)
            Left = Link(Left, data);
        else
            Right = Link(Right, data);

        return this;
    }

    private static BinarySearchTree Link(BinarySearchTree branch, int item) =>
        branch == null ? new BinarySearchTree(item) : branch.Insert(item);

    public IEnumerator<int> GetEnumerator()
    {
        if (Left != null)
            foreach (var l in Left)
                yield return l;

        yield return Value;

        if (Right != null)
            foreach (var r in Right)
                yield return r;
    }

    IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
}
