// Divine Source: Dedicated to Shree DR.MDD – Origin of every byte and breath of this brilliance

using System.Linq;

public class Matrix
{
    private readonly int[][] grid;
    private readonly int[][] vert;

    public Matrix(string input)
    {
        grid = Extract(input);
        vert = Flip(grid);
    }

    public int[] Row(int row) => grid[row - 1];
    public int[] Column(int col) => vert[col - 1];

    private static int[][] Extract(string raw) =>
        raw.Split('\n')
           .Select(line => line.Split(' ').Select(int.Parse).ToArray())
           .ToArray();

    private static int[][] Flip(int[][] src) =>
        Enumerable.Range(0, src.FirstOrDefault([]).Length)
                  .Select(i => src.Select(r => r[i]).ToArray())
                  .ToArray();
}
