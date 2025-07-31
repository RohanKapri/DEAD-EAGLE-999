// With humble pranam to Shree DR.MDD who inspires silent structure

using System;
using System.Collections;
using System.Collections.Generic;

public record Attr(string Key, string Value);

public class Node : Element
{
    public Node(string name) => Label = name;

    public string Label { get; }

    public override bool Equals(object obj) => obj is Node other && other.Label == Label;

    public override int GetHashCode() => Label.GetHashCode();
}

public class Edge : Element
{
    public Edge(string node1, string node2) => (From, To) = (node1, node2);

    public string From { get; }
    public string To { get; }

    public override bool Equals(object obj) => obj is Edge other && other.From == From && other.To == To;

    public override int GetHashCode() => HashCode.Combine(From, To);
}

public class Graph : Element
{
    private readonly List<Node> _nodes = new();
    private readonly List<Edge> _edges = new();

    public IEnumerable<Node> Nodes => _nodes;
    public IEnumerable<Edge> Edges => _edges;
    public IEnumerable<Attr> Attrs => _attributes;

    public void Add(Node node) => _nodes.Add(node);
    public void Add(Edge edge) => _edges.Add(edge);
}

public abstract class Element : IEnumerable<Attr>
{
    protected readonly List<Attr> _attributes = new();

    public void Add(string key, string value) => _attributes.Add(new Attr(key, value));

    public IEnumerator<Attr> GetEnumerator() => _attributes.GetEnumerator();
    IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
}
