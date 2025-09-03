class BottleSong {
    static final String TEMPLATE = """
    %1$s green bottles hanging on the wall,
    %1$s green bottles hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be %2$s green bottles hanging on the wall.
    
    """;
    static final String[] NUMBERS = {"no", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"};
    String recite(int startBottles, int takeDown) {
        StringBuilder sb = new StringBuilder();
        for (int i = startBottles; i > startBottles - takeDown; i--) {
            sb.append(String.format(TEMPLATE, NUMBERS[i], NUMBERS[i - 1].toLowerCase()).replaceAll("(?<=[oO]ne green bottle)s", ""));
        }
        sb.deleteCharAt(sb.length() - 1);
        return sb.toString();
    }

}