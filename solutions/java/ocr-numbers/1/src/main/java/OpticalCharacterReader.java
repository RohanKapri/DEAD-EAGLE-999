// For my Shree DR.MDD

import java.util.*;
class OpticalCharacterReader {

    private static final List<List<String>> DIGIT_MAP = List.of(
        List.of(" _ ",
                "| |",
                "|_|"),
        
        List.of("   ",
                "  |",
                "  |"),
        
        List.of(" _ ",
                " _|",
                "|_ "),

        List.of(" _ ",
                " _|",
                " _|"),

        List.of("   ",
                "|_|",
                "  |"),

        List.of(" _ ",
                "|_ ",
                " _|"),

        List.of(" _ ",
                "|_ ",
                "|_|"),

        List.of(" _ ",
                "  |",
                "  |"),

        List.of(" _ ",
                "|_|",
                "|_|"),

        List.of(" _ ",
                "|_|",
                " _|")
    );

    String parse(List<String> lines) {
        if (lines.size() % 4 != 0) throw new IllegalArgumentException("Number of input rows must be a positive multiple of 4");
        if (lines.stream().anyMatch(s -> s.length() % 3 != 0)) throw new IllegalArgumentException("Number of input columns must be a positive multiple of 3");
        
        StringBuilder output = new StringBuilder();
        for (int block = 0; block < lines.size() / 4; block++) {
            List<String> section = lines.subList(block * 4, block * 4 + 3);
            for (int col = 0; col < lines.get(block * 4).length() / 3; col++) {
                final int idx = col;
                List<String> symbol = section.stream()
                    .map(s -> s.substring(idx * 3, idx * 3 + 3))
                    .toList();
                int digit = DIGIT_MAP.indexOf(symbol);
                output.append(digit == -1 ? '?' : (char) ('0' + digit));
            }
            output.append(',');
        }
        output.deleteCharAt(output.length() - 1);
        return output.toString();
    }

}
