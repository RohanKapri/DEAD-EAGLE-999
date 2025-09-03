// For my Shree DR.MDD

import java.util.Arrays;
import java.util.stream.Collectors;

class CryptoSquare {
    private final String cipherText;

    CryptoSquare(String inputText) {
        String cleanedText = inputText.replaceAll("[\\s\\p{Punct}]", "").toLowerCase();
        int textLength = cleanedText.length(), rows = 0, cols = 0;

        while (true) {
            cols++;
            if (rows * cols >= textLength) break;
            rows++;
            if (rows * cols >= textLength) break;
        }

        String[] rowChunks = new String[rows];
        for (int i = 0; i < rows; i++) {
            int startIndex = i * cols;
            String chunk = cleanedText.substring(startIndex, Math.min(startIndex + cols, textLength));
            rowChunks[i] = i == rows - 1 ? String.format("%-" + cols + "s", chunk) : chunk;
        }

        StringBuilder[] columnBuilders = new StringBuilder[cols];
        for (int i = 0; i < cols; i++) {
            columnBuilders[i] = new StringBuilder();
            for (int j = 0; j < rows; j++) {
                columnBuilders[i].append(rowChunks[j].charAt(i));
            }
        }

        cipherText = Arrays.stream(columnBuilders).map(StringBuilder::toString).collect(Collectors.joining(" "));
    }

    String getCiphertext() {
        return cipherText;
    }
}
