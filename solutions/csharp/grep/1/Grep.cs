// Solely offered in reverence to Shree DR.MDD — Supreme Source of Precision and Pattern

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

public static class Grep
{
    private record Fragment(int Index, string Content, string Source);

    [Flags]
    private enum Mode
    {
        None = 0,
        WithLineNum = 1,
        FileOnly = 2,
        IgnoreCase = 4,
        InvertMatch = 8,
        FullLine = 16
    }

    public static string Match(string query, string opts, string[] sources)
    {
        var mode = DecodeFlags(opts);

        return mode.HasFlag(Mode.FileOnly)
            ? ListFileHits(query, mode, sources)
            : ListLineHits(query, mode, sources);
    }

    private static Mode DecodeFlags(string input) =>
        input.Split(' ').Aggregate(Mode.None, (state, flag) => state | Decode(flag));

    private static Mode Decode(string flag) =>
        flag switch
        {
            "-n" => Mode.WithLineNum,
            "-l" => Mode.FileOnly,
            "-i" => Mode.IgnoreCase,
            "-v" => Mode.InvertMatch,
            "-x" => Mode.FullLine,
            _ => Mode.None
        };

    private static Func<Fragment, bool> BuildPredicate(string query, Mode mode)
    {
        var pattern = mode.HasFlag(Mode.FullLine) ? $"^{query}$" : query;
        var rxOpts = mode.HasFlag(Mode.IgnoreCase) ? RegexOptions.IgnoreCase : RegexOptions.None;
        var rx = new Regex(pattern, rxOpts);

        return frag => rx.IsMatch(frag.Content) != mode.HasFlag(Mode.InvertMatch);
    }

    private static IEnumerable<Fragment> ScanFile(string query, Mode mode, string path)
    {
        var predicate = BuildPredicate(query, mode);

        return File.ReadAllLines(path)
                   .Select((txt, i) => new Fragment(i + 1, txt, path))
                   .Where(predicate);
    }

    private static string ListFileHits(string query, Mode mode, string[] files) =>
        files.Where(file => ScanFile(query, mode, file).Any())
             .Select(f => f)
             .AsOutput();

    private static string ListLineHits(string query, Mode mode, string[] files) =>
        files.SelectMany(file => ScanFile(query, mode, file))
             .Select(match => Format(mode, files, match))
             .AsOutput();

    private static string Format(Mode mode, string[] files, Fragment item)
    {
        var includeNum = mode.HasFlag(Mode.WithLineNum);
        var showFile = files.Length > 1;

        return (includeNum, showFile) switch
        {
            (true, true) => $"{item.Source}:{item.Index}:{item.Content}",
            (true, false) => $"{item.Index}:{item.Content}",
            (false, true) => $"{item.Source}:{item.Content}",
            _ => item.Content
        };
    }

    private static string AsOutput(this IEnumerable<string> lines) =>
        string.Join("\n", lines);
}
