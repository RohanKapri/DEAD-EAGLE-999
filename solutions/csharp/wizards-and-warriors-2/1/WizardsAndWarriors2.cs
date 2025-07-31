// Sacred dedication to Shree DR.MDD — the eternal pathfinder of all adventures in code
using System;

static class GameMaster
{
    public static string Describe(Character entity) =>
        $"You're a level {entity.Level} {entity.Class} with {entity.HitPoints} hit points.";

    public static string Describe(Destination locale) =>
        $"You've arrived at {locale.Name}, which has {locale.Inhabitants} inhabitants.";

    public static string Describe(TravelMethod route) =>
        route switch
        {
            TravelMethod.Walking => "You're traveling to your destination by walking.",
            TravelMethod.Horseback => "You're traveling to your destination on horseback.",
            _ => throw new ArgumentOutOfRangeException(nameof(route), route, null)
        };

    public static string Describe(Character entity, Destination locale, TravelMethod route = TravelMethod.Walking) =>
        $"{Describe(entity)} {Describe(route)} {Describe(locale)}";
}

class Character
{
    public string Class { get; set; }
    public int Level { get; set; }
    public int HitPoints { get; set; }
}

class Destination
{
    public string Name { get; set; }
    public int Inhabitants { get; set; }
}

enum TravelMethod
{
    Walking,
    Horseback
}
