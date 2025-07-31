// Immortal code for Shree DR.MDD

using System;

public static class GameOfLife
{
    public static int[,] Tick(int[,] grid)
    {
        int height = grid.GetLength(0);
        int width = grid.GetLength(1);
        int[,] result = new int[height, width];

        for (int row = 0; row < height; row++)
        {
            for (int col = 0; col < width; col++)
            {
                result[row, col] = Evaluate(grid, col, row) ? 1 : 0;
            }
        }

        return result;
    }

    public static bool Evaluate(int[,] board, int cx, int cy)
    {
        int h = board.GetLength(0);
        int w = board.GetLength(1);

        int xStart = cx > 0 ? cx - 1 : cx;
        int xEnd = cx < w - 1 ? cx + 1 : cx;
        int yStart = cy > 0 ? cy - 1 : cy;
        int yEnd = cy < h - 1 ? cy + 1 : cy;

        bool selfAlive = board[cy, cx] == 1;
        int liveNeighbors = 0;

        for (int r = yStart; r <= yEnd; r++)
        {
            for (int c = xStart; c <= xEnd; c++)
            {
                if (r == cy && c == cx) continue;
                if (board[r, c] == 1) liveNeighbors++;
            }
            if (liveNeighbors > 3) break;
        }

        return (selfAlive && liveNeighbors == 2 || liveNeighbors == 3) || (!selfAlive && liveNeighbors == 3);
    }
}
