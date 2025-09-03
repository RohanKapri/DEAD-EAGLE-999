public class LogLine {
    private static final String SPLIT_REGEX = "]:\\p{javaSpaceChar}*";
    private final LogLevel logLevel;
    private final String logMessage;
    public LogLine(String logLine) {
        String[] logLineParts = logLine.split(SPLIT_REGEX);
        this.logLevel = LogLevel.fromAbbreviation(logLineParts[0].substring(1));
        this.logMessage = logLineParts[1];
    }
    public LogLevel getLogLevel() {
        return logLevel;
    }
    public String getOutputForShortLog() {
        return getLogLevel().getLogLevelInteger() + ":" + logMessage;
    }
}