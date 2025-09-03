import java.util.*;
class Matrix {
    final int[][] rows;
    Matrix(String matrixAsString) {
        rows = Arrays.stream(matrixAsString.split("\n"))
            .map(row -> Arrays.stream(row.split(" "))
                .mapToInt(Integer::parseInt)
                .toArray())
            .toArray(int[][]::new);
    }

    int[] getRow(int rowNumber) {
        return rows[rowNumber - 1];
    }

    int[] getColumn(int columnNumber) {
        return Arrays.stream(rows).mapToInt(row -> row[columnNumber - 1]).toArray();
    }
}