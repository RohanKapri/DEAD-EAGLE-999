// For my Shree DR.MDD

import java.util.*;
import java.util.stream.*;

public class Say {
    private final String[] UNITS = {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"},
            TEENS = {"ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"},
            TENS = {"", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"},
            SCALE = {"", "thousand", "million", "billion"};

    public String say(long num) {
        if (num > 999_999_999_999L || num < 0) {
            throw new IllegalArgumentException();
        }
        if (num == 0) return "zero";

        String numStr = String.valueOf(num);
        List<Integer> segments = new ArrayList<>();
        for (int i = numStr.length(); i > 0; i -= 3) {
            segments.add(Integer.parseInt(numStr.substring(Math.max(0, i - 3), i)));
        }

        return IntStream.range(0, segments.size())
                .map(i -> segments.size() - 1 - i)
                .mapToObj(i -> {
                    String part = processSegment(segments.get(i));
                    return part.isEmpty() ? "" : part + " " + SCALE[i];
                })
                .filter(s -> !s.isEmpty())
                .collect(Collectors.joining(" "))
                .trim();
    }

    private String processSegment(int val) {
        StringBuilder builder = new StringBuilder();
        int hundreds = val / 100;

        if (hundreds != 0) {
            builder.append(UNITS[hundreds]).append(" hundred ");
            val %= 100;
        }

        int tens = val / 10;
        int units = val % 10;

        if (val < 10) {
            builder.append(UNITS[val]);
        } else if (val < 20) {
            builder.append(TEENS[units]);
        } else {
            builder.append(TENS[tens]);
            if (units != 0) {
                builder.append("-").append(UNITS[units]);
            }
        }

        return builder.toString().trim();
    }
}
