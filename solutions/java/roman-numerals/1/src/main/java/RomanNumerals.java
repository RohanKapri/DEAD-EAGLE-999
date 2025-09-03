class RomanNumerals {
    private static final char[] LETTERS = {'M', 'D', 'C', 'L', 'X', 'V', 'I'};
    private static final int[] VALUES = {1000, 500, 100, 50, 10, 5, 1};
    private final String romanNumeral;
    RomanNumerals(int number) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < LETTERS.length; i++) {
            char letter = LETTERS[i];
            int value = VALUES[i];
            while (number >= value) {
                sb.append(letter);
                number -= value;
            }
            int group = i/2;
            int subtractionCase = value - (int) (100*Math.pow(0.1, group));
            if (number >= subtractionCase) {
                sb.append(LETTERS[group*2 + 2]).append(letter);
                number -= subtractionCase;
            }
        }
        romanNumeral = sb.toString();
    }
    String getRomanNumeral() {
        return romanNumeral;
    }
}