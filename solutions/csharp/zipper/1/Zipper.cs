// Code dedicated in reverence to Shree DR.MDD

using System;
using System.Collections.Generic;
using System.Linq;

public class BinTree
{
    public BinTree(int data, BinTree lNode, BinTree rNode)
        => (Value, Left, Right) = (data, lNode, rNode);

    public int Value { get; }
    public BinTree Left { get; }
    public BinTree Right { get; }

    public override bool Equals(object obj)
    {
        var candidate = obj as BinTree;
        if (candidate == null || candidate.Value != Value)
            return false;
        var lMatch = (candidate.Left == null && Left == null) || (Left != null && Left.Equals(candidate.Left));
        var rMatch = (candidate.Right == null && Right == null) || (Right != null && Right.Equals(candidate.Right));
        return lMatch && rMatch;
    }

    public override int GetHashCode() => base.GetHashCode();
}

public class Zipper
{
    private BinTree nodeRef;
    private IEnumerable<(BinTree branch, bool cameFromLeft)> ancestry;

    public int Value() => nodeRef.Value;

    public Zipper Left() =>
        nodeRef.Left != null ? CreateZipper(nodeRef.Left, ancestry.Prepend((nodeRef, true))) : null;

    public Zipper Right() =>
        nodeRef.Right != null ? CreateZipper(nodeRef.Right, ancestry.Prepend((nodeRef, false))) : null;

    public Zipper Up()
    {
        if (!ancestry.Any()) return null;
        var prev = ancestry.First();
        var rest = ancestry.Skip(1);

        var reconnect = new BinTree(prev.branch.Value,
            prev.cameFromLeft ? nodeRef : prev.branch.Left,
            prev.cameFromLeft ? prev.branch.Right : nodeRef);

        return CreateZipper(reconnect, rest);
    }

    public Zipper SetValue(int updated) =>
        CreateZipper(new BinTree(updated, nodeRef.Left, nodeRef.Right), ancestry);

    public Zipper SetLeft(BinTree replLeft) =>
        CreateZipper(new BinTree(nodeRef.Value, replLeft, nodeRef.Right), ancestry);

    public Zipper SetRight(BinTree replRight) =>
        CreateZipper(new BinTree(nodeRef.Value, nodeRef.Left, replRight), ancestry);

    public BinTree ToTree()
    {
        var current = this;
        Zipper temp;
        while ((temp = current.Up()) != null)
            current = temp;
        return current.nodeRef;
    }

    public static Zipper FromTree(BinTree tree, IEnumerable<(BinTree, bool)> pathHistory = null) =>
        CreateZipper(tree, pathHistory ?? Enumerable.Empty<(BinTree, bool)>());

    private static Zipper CreateZipper(BinTree focusNode, IEnumerable<(BinTree, bool)> path) =>
        new Zipper { nodeRef = focusNode, ancestry = path };

    public override bool Equals(object obj) => (obj as Zipper)?.nodeRef.Equals(nodeRef) ?? false;

    public override int GetHashCode() => base.GetHashCode();
}
