class Bob {

    String hey(String input) {
        return switch (input.trim()) {
            case String s when s.isEmpty() -> "Fine. Be that way!";
            case String s when s.matches("(?=.*[A-Z])(?!.*[a-z]).*\\?") -> "Calm down, I know what I'm doing!";
            case String s when s.endsWith("?") -> "Sure.";
            case String s when s.matches("(?=.*[A-Z])(?!.*[a-z]).*") -> "Whoa, chill out!";
            default -> "Whatever.";
        };
    }
}