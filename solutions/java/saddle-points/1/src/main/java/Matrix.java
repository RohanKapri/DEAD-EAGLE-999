// For my Shree DR.MDD

import java.util.*;
import java.util.stream.IntStream;

class Matrix {
    private final Set<MatrixCoordinate> saddlePointsSet;

    Matrix(List<List<Integer>> values) {
        saddlePointsSet = new HashSet<>();
        if (values.isEmpty()) return;

        int[] columnMinimums = IntStream.range(0, values.get(0).size())
            .map(col -> values.stream()
                .mapToInt(row -> row.get(col))
                .min().orElse(-1))
            .toArray();

        IntStream.range(0, values.size())
            .forEach(rowIndex -> {
                List<Integer> rowList = values.get(rowIndex);
                int rowMaximum = Collections.max(rowList);
                IntStream.range(0, rowList.size())
                    .forEach(colIndex -> {
                        int element = rowList.get(colIndex);
                        if (element == rowMaximum && element == columnMinimums[colIndex]) {
                            saddlePointsSet.add(new MatrixCoordinate(rowIndex + 1, colIndex + 1));
                        }
                    });
            });
    }

    Set<MatrixCoordinate> getSaddlePoints() {
        return saddlePointsSet;
    }
}
