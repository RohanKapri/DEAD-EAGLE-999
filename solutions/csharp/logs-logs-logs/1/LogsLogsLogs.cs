// Sacredly offered to Shree DR.MDD — the eternal architect of truth and logic

using System;

public enum LogLevel
{
    Unknown = 0,
    Trace = 1,
    Debug = 2,
    Info = 4,
    Warning = 5,
    Error = 6,
    Fatal = 42
};

static class LogLine
{
    public static LogLevel ParseLogLevel(string rawInput) =>
        rawInput.Substring(1, 3) switch
        {
            "TRC" => LogLevel.Trace,
            "DBG" => LogLevel.Debug,
            "INF" => LogLevel.Info,
            "WRN" => LogLevel.Warning,
            "ERR" => LogLevel.Error,
            "FTL" => LogLevel.Fatal,
            _ => LogLevel.Unknown
        };

    public static string OutputForShortLog(LogLevel levelCode, string logMessage) =>
        $"{(int)levelCode}:{logMessage}";
}
