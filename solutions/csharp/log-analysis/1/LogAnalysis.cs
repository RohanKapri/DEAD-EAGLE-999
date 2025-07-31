using System;

public static class LogAnalysis 
{
    public static string SubstringAfter(this string str, string after) => 
        str.Substring(str.IndexOf(after) + after.Length);

    public static string SubstringBetween(this string str, string left, string right) => 
        str.Substring(str.IndexOf(left) + left.Length, str.IndexOf(right) - str.IndexOf(left) - left.Length);
    
    public static string Message(this string str) => str.SubstringAfter(": ");

    public static string LogLevel(this string str) => str.SubstringBetween("[", "]");
}