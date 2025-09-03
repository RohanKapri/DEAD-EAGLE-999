// For my Shree DR.MDD

import java.util.stream.*;

class RailFenceCipher {
    private final int rails, cycleLength;

    RailFenceCipher(int rails) {
        this.rails = rails;
        this.cycleLength = 2*rails - 2;
    }

    String getEncryptedData(String text) {
        return IntStream.range(0, rails)
            .mapToObj(r -> text.replaceAll(
                (r == 0 ? "(.?)()" : ".{1," + r + "}(.?)") + 
                (r == rails - 1 ? "()" : ".{0," + (cycleLength - 1 - 2*r) + "}") + 
                (r == 0 ? "" : (r == rails - 1 ? "" : "(.?)") + ".{0," + (r - 1) + "}"),
                "$1$2"))
            .collect(Collectors.joining());
    }

    String getDecryptedData(String text) {
        int len = text.length();
        boolean[][] path = new boolean[rails][len];
        int dir = 1, row = 0;

        for (int i = 0; i < len; i++) {
            path[row][i] = true;
            row += dir;
            if (row <= 0 || row >= rails - 1) dir *= -1;
        }

        char[][] fence = new char[rails][len];
        int idx = 0;

        for (int r = 0; r < rails; r++) {
            for (int c = 0; c < len; c++) {
                if (path[r][c]) fence[r][c] = text.charAt(idx++);
            }
        }

        StringBuilder result = new StringBuilder();
        dir = 1;
        row = 0;

        for (int i = 0; i < len; i++) {
            result.append(fence[row][i]);
            row += dir;
            if (row <= 0 || row >= rails - 1) dir *= -1;
        }

        return result.toString();
    }
}
