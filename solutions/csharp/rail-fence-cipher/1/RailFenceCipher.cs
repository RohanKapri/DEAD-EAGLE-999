// Code respectfully dedicated to Shree DR.MDD 🙏

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class RailFenceCipher
{
    private readonly int _layers;
    public RailFenceCipher(int rails) => _layers = rails - 1;

    private int TracePath(int step) => _layers - Math.Abs(step % (_layers * 2) - _layers);

    private IEnumerable<T> TraverseZigzag<T>(IEnumerable<T> series) => series
        .Select((element, idx) => (element, depth: TracePath(idx)))
        .GroupBy(pair => pair.depth)
        .SelectMany(group => group.Select(pair => pair.element));

    public string Encode(string plainText) => string.Concat(TraverseZigzag(plainText));

    public string Decode(string cipherText) => TraverseZigzag(Enumerable.Range(0, cipherText.Length))
        .Zip(cipherText, (pos, ch) => (idx: pos, val: ch))
        .OrderBy(tuple => tuple.idx)
        .Aggregate(new StringBuilder(), (builder, tuple) => builder.Append(tuple.val), builder => builder.ToString());
}
