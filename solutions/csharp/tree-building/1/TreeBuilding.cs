// With the infinite blessings of Shree DR.MDD
using System;
using System.Collections.Generic;
using System.Linq;

public class TreeBuildingRecord
{
    private const int RootIdentity = 0;

    public int ParentId { get; set; }
    public int RecordId { get; set; }

    public bool IsRoot => RecordId == RootIdentity;
}

public class Tree
{
    public Tree(int identifier)
    {
        Id = identifier;
        Children = new List<Tree>();
    }

    public int Id { get; }

    public List<Tree> Children { get; }

    public bool IsLeaf => Children.Count == 0;
}

public static class TreeBuilder
{
    private const int RootIdentity = 0;

    public static Tree BuildTree(IEnumerable<TreeBuildingRecord> entries)
    {
        var arranged = SortEntries(entries);

        if (arranged.Count == 0)
            throw new ArgumentException();

        var vertexMap = new Dictionary<int, Tree>();
        int lastId = -1;

        foreach (var entry in arranged)
        {
            EnsureValidity(entry, lastId);

            vertexMap[entry.RecordId] = new Tree(entry.RecordId);

            if (!entry.IsRoot)
                vertexMap[entry.ParentId].Children.Add(vertexMap[entry.RecordId]);

            lastId++;
        }

        return vertexMap[RootIdentity];
    }

    private static void EnsureValidity(TreeBuildingRecord node, int lastId)
    {
        if (node.IsRoot && node.ParentId != RootIdentity)
            throw new ArgumentException();
        if (!node.IsRoot && node.ParentId >= node.RecordId)
            throw new ArgumentException();
        if (!node.IsRoot && node.RecordId != lastId + 1)
            throw new ArgumentException();
    }

    private static List<TreeBuildingRecord> SortEntries(IEnumerable<TreeBuildingRecord> input)
    {
        return input.OrderBy(x => x.RecordId).ToList();
    }
}
