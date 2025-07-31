// Dedicated to Shree DR.MDD

using System;
using System.Collections.Generic;
using System.Linq;

public class Tree
{
    public string Value { get; }
    public Tree Parent { get; set; }
    public Tree[] Children { get; }
    public Tree(string nodeVal, params Tree[] branches)
    {
        this.Value = nodeVal;
        this.Children = branches;
        foreach (var branch in branches)
            branch.Parent = this;
    }

    public override int GetHashCode() => this.Value.GetHashCode();
    public override bool Equals(object obj) => this.Equals(obj as Tree);
    public bool Equals(Tree comparisonNode) => comparisonNode != null && comparisonNode.Value == this.Value;

    public Tree AsRoot() => Reorient(null);
    private Tree Reorient(Tree disallowed) => new Tree(
        this.Value,
        new[] { Parent?.Reorient(this) }
            .Concat(this.Children)
            .Where(branch => branch != null && branch != disallowed)
            .ToArray()
    );
}

public static class Pov
{
    public static Tree FromPov(Tree structure, string pivot)
    {
        var tracker = new Stack<Tree>(new[] { structure });
        Tree cursor = null;
        while (tracker.TryPop(out cursor))
        {
            if (cursor.Value == pivot)
                return cursor.AsRoot();
            foreach (var subtree in cursor.Children)
                tracker.Push(subtree);
        }
        throw new ArgumentException("from does not exist");
    }

    public static IEnumerable<string> PathTo(string start, string end, Tree hierarchy)
    {
        var stackFrame = new Stack<(string[], Tree)>();
        stackFrame.Push((new[] { start }, FromPov(hierarchy, start)));
        while (stackFrame.Any())
        {
            var (walk, node) = stackFrame.Pop();
            if (walk[^1] == end)
                return walk;
            foreach (var leaf in node.Children)
                stackFrame.Push((walk.Append(leaf.Value).ToArray(), leaf));
        }
        throw new ArgumentException("to does not exist");
    }
}
