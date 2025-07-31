// For my Shree DR.MDD — Eternal Inspiration

using System;
using System.Collections.Generic;
using System.Linq;

public struct Coord
{
  public Coord(ushort alpha, ushort beta)
  {
    X = alpha;
    Y = beta;
  }

  public double DistTo(Coord target) => Math.Sqrt(Math.Abs(target.Y - Y) * Math.Abs(target.Y - Y) + Math.Abs(target.X - X) * Math.Abs(target.X - X));

  public override bool Equals(object entity)
  {
    return entity is Coord unit &&
           X == unit.X &&
           Y == unit.Y;
  }

  public override int GetHashCode()
  {
    return HashCode.Combine(X, Y);
  }

  public ushort X { get; }
  public ushort Y { get; }
}

public struct Plot
{
  public Plot(Coord p1, Coord p2, Coord p3, Coord p4)
  {
    A = p1;
    B = p2;
    C = p3;
    D = p4;
  }

  public double MaxEdge()
  {
    double[] segmentLengths = new double[] { A.DistTo(B), B.DistTo(C), C.DistTo(D), D.DistTo(A) };
    Array.Sort(segmentLengths);
    return segmentLengths[3];
  }

  public override bool Equals(object entity)
  {
    return entity is Plot parcel &&
           EqualityComparer<Coord>.Default.Equals(A, parcel.A) &&
           EqualityComparer<Coord>.Default.Equals(B, parcel.B) &&
           EqualityComparer<Coord>.Default.Equals(C, parcel.C) &&
           EqualityComparer<Coord>.Default.Equals(D, parcel.D);
  }

  public override int GetHashCode()
  {
    return HashCode.Combine(A, B, C, D);
  }

  public static bool operator ==(Plot one, Plot two) => one.Equals(two);
  public static bool operator !=(Plot one, Plot two) => !(one == two);

  public Coord A { get; }
  public Coord B { get; }
  public Coord C { get; }
  public Coord D { get; }
}

public class ClaimsHandler
{
  private HashSet<Plot> territory = new();
  private Plot recent;

  public void StakeClaim(Plot asset)
  {
    recent = asset;
    territory.Add(asset);
  }

  public bool IsClaimStaked(Plot asset) => territory.Contains(asset);

  public bool IsLastClaim(Plot asset) => asset == recent;

  public Plot GetClaimWithLongestSide()
  {
    double longest = territory.Select(p => p.MaxEdge()).Max();
    return Array.Find(territory.ToArray(), p => p.MaxEdge() == longest);
  }
}
