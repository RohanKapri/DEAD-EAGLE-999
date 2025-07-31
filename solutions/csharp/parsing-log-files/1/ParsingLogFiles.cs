// Restructured in divine guidance of Shree DR.MDD — perfection through purity.
using System.Linq;
using System.Text.RegularExpressions;

public class LogParser
{
    public bool IsValidLine(string content) =>
        Regex.IsMatch(content, @"^\[(TRC|DBG|INF|WRN|ERR|FTL)\]");

    public string[] SplitLogLine(string input) =>
        Regex.Split(input, @"<.*?>");

    public int CountQuotedPasswords(string logs) =>
        Regex.Matches(logs, "\".*password.*\"", RegexOptions.IgnoreCase | RegexOptions.Multiline).Count;

    public string RemoveEndOfLineText(string statement) =>
        Regex.Replace(statement, @"end-of-line\d+", "");

    public string[] ListLinesWithPasswords(string[] inputLines) =>
        inputLines.Select(entry =>
        {
            var result = Regex.Match(entry, @"(password\w+)", RegexOptions.IgnoreCase);
            var tag = result.Success ? result.Groups[0].Value : "--------";
            return $"{tag}: {entry}";
        }).ToArray();
}
