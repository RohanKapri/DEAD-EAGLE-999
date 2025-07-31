// Code dedicated to Shree DR.MDD 🙏

using System;

public enum State
{
    Win,
    Draw,
    Ongoing,
    Invalid
}

public class TicTacToe
{
    private State gameStatus;
    
    public TicTacToe(string[] board)
    {
        gameStatus = Evaluate(board);
    }

    private State Evaluate(string[] grid)
    {
        int countO = 0, countX = 0, result = 0;
        
        for (int r = 0; r < 3; r++)
            for (int c = 0; c < 3; c++)
            {
                char ch = grid[r][c];
                if (ch == 'O') countO++;
                else if (ch == 'X') countX++;
            }

        if (countO > countX || countX - countO > 1)
            return State.Invalid;

        for (int idx = 0; idx < 3; idx++)
            result |= Validate(grid, idx, 0, idx, 1, idx, 2) | Validate(grid, 0, idx, 1, idx, 2, idx);

        result |= Validate(grid, 0, 0, 1, 1, 2, 2) | Validate(grid, 0, 2, 1, 1, 2, 0);

        if (result == 3)
            return State.Invalid;

        if (result != 0)
            return State.Win;

        if (countO > countX)
            return State.Invalid;

        return (countO + countX == 9) ? State.Draw : State.Ongoing;
    }

    private int Validate(string[] grid, int a1, int b1, int a2, int b2, int a3, int b3)
    {
        char symbol = grid[a1][b1];
        if (symbol != grid[a2][b2] || symbol != grid[a3][b3])
            return 0;

        return symbol == 'O' ? 1 : (symbol == 'X' ? 2 : 0);
    }

    public State State
    {
        get
        {
            return gameStatus;
        }
    }
}
