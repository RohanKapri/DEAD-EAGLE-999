using System;
using System.Collections.Generic;
using System.Linq;

public enum Owner
{
    Black,
    White,
    None
}

public class GoCounting
{
    private int xLimit;
    private int yLimit;
    private char[][] playerBoard;
    private List<GoTerritory> territories;
    private Dictionary<Owner, IEnumerable<(int, int)>> territoriesByOwner = new Dictionary<Owner, IEnumerable<(int, int)>>();

    public GoCounting(string board)
    {
        var rows = board.Split("\n");
        xLimit = rows[0].Length;
        yLimit = rows.Length;
        playerBoard = new char[yLimit][];
        for (int i = 0; i < rows.Length; i++)
        {
            playerBoard[i] = rows[i].ToCharArray();
        }
        territories = new List<GoTerritory>();
        for (int y = 0; y < yLimit; y++)
        {
            for (int x = 0; x < xLimit; x++)
            {
                if (playerBoard[y][x] == ' ' && GetGoTerritoryFromTerritories((x, y)) == null)
                {
                    territories.Add(new GoTerritory(this, (x, y)));
                }
            }
        }

        foreach (var owner in Enum.GetValues(typeof(Owner)))
        {
            var playerTerritory = new List<(int, int)>();
            foreach (var ter in territories.Where(t => t.GetOwner().Equals((Owner)owner)))
            {
                playerTerritory.AddRange(ter.territory);
            }
            territoriesByOwner.Add((Owner)owner, playerTerritory.ToArray());
        }
    }

    public Tuple<Owner, IEnumerable<(int, int)>> Territory((int, int) coord) => Tuple.Create(GetTerritoryOwner(coord), GetTerritory(coord));

    public Dictionary<Owner, IEnumerable<(int, int)>> Territories() => territoriesByOwner;

    private Owner GetTerritoryOwner((int, int) coord)
    {
        CheckCoordinates(coord);
        return GetGoTerritoryFromTerritories(coord)?.GetOwner() ?? Owner.None;
    }

    private IEnumerable<(int, int)> GetTerritory((int, int) coord)
    {
        CheckCoordinates(coord);
        return GetGoTerritoryFromTerritories(coord)?.territory.ToArray() ?? Array.Empty<(int, int)>();
    }

    private void CheckCoordinates((int, int) coord)
    {
        if (coord.Item1 < 0 || coord.Item2 < 0 || coord.Item1 >= xLimit || coord.Item2 >= yLimit)
        {
            throw new ArgumentException("Invalid coordinate");
        }
    }

    private GoTerritory GetGoTerritoryFromTerritories((int, int) coord) => territories.Where(t => t.territory.Contains(coord)).FirstOrDefault();

    private class GoTerritory
    {
        public List<(int, int)> territory = new List<(int, int)>();
        private List<Owner> borderOwners = new List<Owner>();
        private GoCounting goCounting;

        public GoTerritory(GoCounting goCounting, (int, int) pointStart)
        {
            this.goCounting = goCounting;
            territory.Add(pointStart);  // We believe that there is no stone at the start point.
            for (int i = 0; i < territory.Count; i++)
            {
                var currentPoint = territory[i];
                if (currentPoint.Item2 - 1 >= 0)
                {
                    ProcessPoint(currentPoint.Item1, currentPoint.Item2 - 1); // up
                }
                if (currentPoint.Item2 + 1 < goCounting.yLimit)
                {
                    ProcessPoint(currentPoint.Item1, currentPoint.Item2 + 1); // down
                }
                if (currentPoint.Item1 + 1 < goCounting.xLimit)
                {
                    ProcessPoint(currentPoint.Item1 + 1, currentPoint.Item2); // right
                }
                if (currentPoint.Item1 - 1 >= 0)
                {
                    ProcessPoint(currentPoint.Item1 - 1, currentPoint.Item2); // left
                }
            }
        }

        public Owner GetOwner() => borderOwners.Count == 0 || (borderOwners.Contains(Owner.Black) && borderOwners.Contains(Owner.White))
                ? Owner.None
                : borderOwners.Contains(Owner.Black) ? Owner.Black : Owner.White;

        private void ProcessPoint(int x, int y)
        {
            var point = (x, y);
            if (goCounting.playerBoard[y][x] == 'B')
            {
                borderOwners.Add(Owner.Black);
            }
            if (goCounting.playerBoard[y][x] == 'W')
            {
                borderOwners.Add(Owner.White);
            }
            if (goCounting.playerBoard[y][x] == ' ' && !territory.Contains(point))
            {
                territory.Add(point);
            }
        }
    }
}