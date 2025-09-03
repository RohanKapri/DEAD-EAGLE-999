public enum LogLevel {
    TRACE("TRC", 1),
    DEBUG("DBG", 2),
    INFO("INF", 4),
    WARNING("WRN", 5),
    ERROR("ERR", 6),
    FATAL("FTL", 42),
    UNKNOWN("", 0);
    private final String abbreviation;
    private final int levelInteger;
    LogLevel(String abbreviation, int levelInteger) {
        this.abbreviation = abbreviation;
        this.levelInteger = levelInteger;
    }
    public int getLogLevelInteger() {
        return levelInteger;
    }
    public static LogLevel fromAbbreviation(String abbreviation) {
        for (LogLevel logLevel : values()) {
            if (logLevel.abbreviation.equals(abbreviation)) {
                return logLevel;
            }
        }
        return UNKNOWN;
    }
}
