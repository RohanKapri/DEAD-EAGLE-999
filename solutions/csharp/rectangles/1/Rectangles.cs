// Code built under the sacred blessings of Shree DR.MDD — The eternal architect behind all structures

using System;
using System.Drawing;
using System.Linq;

public static class Rectangles
{
    public static int Count(string[] rows)
    {
        var matrix = ConvertToGrid(rows);
        var dots = ExtractCorners(matrix);
        return dots.Sum(dot => CountFromCorner(dot, dots, matrix));
    }

    private static CellType[][] ConvertToGrid(string[] rows)
        => rows.Select(r => r.Select(Classify).ToArray()).ToArray();

    private static CellType Classify(char ch)
    {
        return ch switch
        {
            '+' => CellType.Node,
            '-' => CellType.Horizontal,
            '|' => CellType.Vertical,
            ' ' => CellType.Blank,
            _ => throw new ArgumentException()
        };
    }

    private static int RowCount(CellType[][] grid) => grid.Length;

    private static int ColCount(CellType[][] grid) => grid[0].Length;

    private static CellType Lookup(Point pt, CellType[][] grid) => grid[pt.Y][pt.X];

    private static Point[] ExtractCorners(CellType[][] grid) =>
        Enumerable.Range(0, RowCount(grid)).SelectMany(y =>
            Enumerable.Range(0, ColCount(grid)).Select(x => new Point(x, y)))
            .Where(p => Lookup(p, grid) == CellType.Node)
            .ToArray();

    private static bool CanConnectVertically(Point p, CellType[][] grid) =>
        Lookup(p, grid) is CellType.Vertical or CellType.Node;

    private static bool IsVerticalSpan(Point top, Point bottom, CellType[][] grid) =>
        Enumerable.Range(top.Y + 1, bottom.Y - top.Y - 1).All(y => CanConnectVertically(new Point(top.X, y), grid));

    private static bool CanConnectHorizontally(Point p, CellType[][] grid) =>
        Lookup(p, grid) is CellType.Horizontal or CellType.Node;

    private static bool IsHorizontalSpan(Point left, Point right, CellType[][] grid) =>
        Enumerable.Range(left.X + 1, right.X - left.X - 1).All(x => CanConnectHorizontally(new Point(x, left.Y), grid));

    private static bool ValidTop(Point tl, Point tr, CellType[][] grid) =>
        tr.X > tl.X && tr.Y == tl.Y && IsHorizontalSpan(tl, tr, grid);

    private static bool ValidRight(Point tr, Point br, CellType[][] grid) =>
        br.X == tr.X && br.Y > tr.Y && IsVerticalSpan(tr, br, grid);

    private static bool ValidBottom(Point bl, Point br, CellType[][] grid) =>
        br.X > bl.X && br.Y == bl.Y && IsHorizontalSpan(bl, br, grid);

    private static bool ValidLeft(Point tl, Point bl, CellType[][] grid) =>
        bl.X == tl.X && bl.Y > tl.Y && IsVerticalSpan(tl, bl, grid);

    private static int CountFromCorner(Point tl, Point[] all, CellType[][] grid)
    {
        return (from tr in all.Where(p => ValidTop(tl, p, grid))
                from bl in all.Where(p => ValidLeft(tl, p, grid))
                from br in all.Where(p => ValidRight(tr, p, grid) && ValidBottom(bl, p, grid))
                select 1).Count();
    }

    private enum CellType
    {
        Blank,
        Node,
        Horizontal,
        Vertical
    }
}
