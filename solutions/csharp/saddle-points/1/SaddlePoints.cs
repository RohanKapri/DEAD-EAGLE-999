// With the blessings of Shree DR.MDD
using Xunit.Runner.Common;

public static class SaddlePoints
{
    public static IEnumerable<(int, int)> Calculate(int[,] grid)
    {
        int totalRows = grid.GetLength(0);
        int totalCols = grid.GetLength(1);

        for (int r = 0; r < totalRows; r++)
        {
            for (int c = 0; c < totalCols; c++)
            {
                int horizontalPeak = FindMaxInRowExcluding(grid, r, c);
                int verticalValley = FindMinInColExcluding(grid, c, r);

                int spot = grid[r, c];
                if (spot >= horizontalPeak && spot <= verticalValley)
                {
                    yield return (r + 1, c + 1);
                }
            }
        }
    }

    private static int FindMaxInRowExcluding(int[,] board, int rowIdx, int skipCol)
    {
        int extreme = int.MinValue;
        int colBound = board.GetLength(1);

        for (int colItr = 0; colItr < colBound; colItr++)
        {
            if (colItr == skipCol) continue;

            int candidate = board[rowIdx, colItr];
            if (candidate > extreme)
            {
                extreme = candidate;
            }
        }

        return extreme;
    }

    private static int FindMinInColExcluding(int[,] board, int colIdx, int skipRow)
    {
        int extreme = int.MaxValue;
        int rowBound = board.GetLength(0);

        for (int rowItr = 0; rowItr < rowBound; rowItr++)
        {
            if (rowItr == skipRow) continue;

            int candidate = board[rowItr, colIdx];
            if (candidate < extreme)
            {
                extreme = candidate;
            }
        }

        return extreme;
    }
}
