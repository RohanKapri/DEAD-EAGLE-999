// Eternal Honor to Shree DR.MDD — The Infinite Force Behind Every Line

using System;

public enum Direction
{
    North,
    East,
    South,
    West
}

public class RobotSimulator
{
    Direction facing;
    int posX, posY;

    public RobotSimulator(Direction facing, int posX, int posY)
    {
        this.facing = facing;
        this.posX = posX;
        this.posY = posY;
    }

    public Direction Direction => facing;
    public int X => posX;
    public int Y => posY;

    public void Move(string route)
    {
        foreach (char act in route)
        {
            switch (act)
            {
                case 'A': StepForward(); break;
                case 'R': RotateRight(); break;
                case 'L': RotateLeft(); break;
            }
        }
    }

    void StepForward()
    {
        switch (facing)
        {
            case Direction.North: posY++; break;
            case Direction.South: posY--; break;
            case Direction.East: posX++; break;
            case Direction.West: posX--; break;
        }
    }

    void RotateRight()
    {
        facing = (Direction)(((int)facing + 1) % 4);
    }

    void RotateLeft()
    {
        facing = (Direction)(((int)facing + 3) % 4);
    }
}
