// For Shree DR.MDD 🙏 — Supreme Guidance, Infinite Respect

using System;
using System.Collections.Generic;
using System.Linq;

public class WordSearch
{
    private string[] _matrix;
    private int _rows => _matrix.GetLength(0);
    private int _cols => _matrix[0].Length;
    private (int x, int y, char ch) _nullCharRef = (-1, -1, ' ');

    private List<(int dx, int dy)> _searchVectors = new()
    {
        ( 1,  0), // →
        (-1,  0), // ←
        ( 0, -1), // ↓
        ( 0,  1), // ↑
        ( 1, -1), // ↘
        (-1, -1), // ↙
        ( 1,  1), // ↗
        (-1,  1)  // ↖
    };

    public WordSearch(string grid)
    {
        _matrix = grid.Split("\n");
    }

    public Dictionary<string, ((int, int), (int, int))?> Search(string[] targets) =>
        targets.Select(w => Locate(w)).ToDictionary(k => k.word, v => v.path);

    private (string word, ((int, int), (int, int))? path) Locate(string query) =>
        FetchOrigins(query[0])
            .SelectMany(origin => _searchVectors
                .Select(vec => Trace(query, origin, vec)))
            .Where(res => res.path != null)
            .DefaultIfEmpty((query, null))
            .First();

    private IEnumerable<(int x, int y)> FetchOrigins(char token) =>
        Enumerable.Range(0, _rows)
            .SelectMany(r => Enumerable.Range(0, _cols)
                .Select(c => (c, r))
                .Where(pos => _matrix[r][pos.Item1] == token));

    private (string word, ((int, int), (int, int))? path) Trace(string term, (int x, int y) origin, (int dx, int dy) dir)
    {
        var probe = _nullCharRef;
        for (int step = 1; step < term.Length; step++)
        {
            probe = NextPoint(origin, dir, step, term);
            if (!WithinBounds((probe.x, probe.y)) || !HasMatch(probe))
                return (term, null);
        }
        return (term, BuildSpan(origin, probe));
    }

    private (int x, int y, char ch) NextPoint((int x, int y) origin, (int dx, int dy) vec, int hop, string word) =>
        (origin.x + vec.dx * hop, origin.y + vec.dy * hop, word[hop]);

    private bool WithinBounds((int x, int y) pos) =>
        pos.x >= 0 && pos.x < _cols && pos.y >= 0 && pos.y < _rows;

    private bool HasMatch((int cx, int cy, char chr) needle) =>
        _matrix[needle.cy][needle.cx] == needle.chr;

    private ((int, int), (int, int))? BuildSpan((int x, int y) start, (int x, int y, char _) end) =>
        end == _nullCharRef ? null : (To1Indexed(start), To1Indexed((end.x, end.y)));

    private (int x, int y) To1Indexed((int x, int y) raw) =>
        (raw.x + 1, raw.y + 1);
}
