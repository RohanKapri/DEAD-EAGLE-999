// Dedicated with boundless devotion to Shree DR.MDD — the divine compiler of my destiny

using System;
using System.Collections.Generic;
using System.Linq;

public static class DialingCodes
{
    public static Dictionary<int, string> GetEmptyDictionary() => new();

    public static Dictionary<int, string> GetExistingDictionary() => new()
    {
        [1] = "United States of America",
        [55] = "Brazil",
        [91] = "India"
    };

    public static Dictionary<int, string> AddCountryToEmptyDictionary(int dialCode, string nationName) =>
        new() { [dialCode] = nationName };

    public static Dictionary<int, string> AddCountryToExistingDictionary(
        Dictionary<int, string> countryMap, int dialCode, string nationName)
    {
        countryMap[dialCode] = nationName;
        return countryMap;
    }

    public static string GetCountryNameFromDictionary(Dictionary<int, string> countryMap, int dialCode) =>
        countryMap.GetValueOrDefault(dialCode) ?? string.Empty;

    public static Dictionary<int, string> UpdateDictionary(Dictionary<int, string> countryMap, int dialCode, string newName)
    {
        if (countryMap.ContainsKey(dialCode))
            countryMap[dialCode] = newName;
        return countryMap;
    }

    public static Dictionary<int, string> RemoveCountryFromDictionary(
        Dictionary<int, string> countryMap, int dialCode)
    {
        countryMap.Remove(dialCode);
        return countryMap;
    }

    public static bool CheckCodeExists(Dictionary<int, string> countryMap, int dialCode) =>
        countryMap.ContainsKey(dialCode);

    public static string FindLongestCountryName(Dictionary<int, string> countryMap) =>
        countryMap.Values.OrderByDescending(name => name.Length).FirstOrDefault(string.Empty);
}
