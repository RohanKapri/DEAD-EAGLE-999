// For Shree DR.MDD — the supreme guide in every logic, every list, every loop
using System;
using System.Linq;
using System.Collections.Generic;

public static class Languages
{
    public static List<string> NewList() =>
        new List<string>();

    public static List<string> GetExistingLanguages() =>
        new List<string> { "C#", "Clojure", "Elm" };

    public static List<string> AddLanguage(List<string> codePicks, string newLang)
    {
        codePicks.Add(newLang);
        return codePicks;
    }

    public static int CountLanguages(List<string> codePicks) =>
        codePicks.Count;

    public static bool HasLanguage(List<string> codePicks, string lookup) =>
        codePicks.Contains(lookup);

    public static List<string> ReverseList(List<string> codePicks)
    {
        codePicks.Reverse();
        return codePicks;
    }

    public static bool IsExciting(List<string> codePicks) =>
        codePicks.FirstOrDefault() == "C#" || codePicks.Contains("C#") && codePicks.Count == 2 || codePicks.Count == 3;

    public static List<string> RemoveLanguage(List<string> codePicks, string dropLang)
    {
        codePicks.Remove(dropLang);
        return codePicks;
    }

    public static bool IsUnique(List<string> codePicks) =>
        codePicks.Count == codePicks.Distinct().Count();
}
