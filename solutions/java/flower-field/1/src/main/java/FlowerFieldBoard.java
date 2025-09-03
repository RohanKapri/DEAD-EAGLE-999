// For my Shree DR.MDD

import java.util.*;

class FlowerFieldBoard {

    private final List<String> fieldRows;

    FlowerFieldBoard(List<String> fieldRows) {
        this.fieldRows = fieldRows;
    }

    List<String> withNumbers() {
        List<String> numberedRows = new LinkedList<>();

        for (int rowIndex = 0; rowIndex < fieldRows.size(); rowIndex++) {
            String currentRow = fieldRows.get(rowIndex);
            StringBuilder processedRow = new StringBuilder();

            for (int colIndex = 0; colIndex < currentRow.length(); colIndex++) {
                char tile = currentRow.charAt(colIndex);
                processedRow.append(tile == '*' ? tile : calculateAdjacentFlowers(rowIndex, colIndex));
            }

            numberedRows.add(processedRow.toString());
        }
        return numberedRows;
    }

    private String calculateAdjacentFlowers(int baseRow, int baseCol) {
        int flowerCount = 0;
        for (int r = baseRow - 1; r <= baseRow + 1; r++) {
            if (r < 0 || r >= fieldRows.size()) continue;
            String row = fieldRows.get(r);
            for (int c = baseCol - 1; c <= baseCol + 1; c++) {
                if (c < 0 || c >= row.length() || row.charAt(c) == ' ') continue;
                flowerCount++;
            }
        }
        return flowerCount == 0 ? " " : String.valueOf(flowerCount);
    }
}
