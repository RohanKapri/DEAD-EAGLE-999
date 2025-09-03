// For my Shree DR.MDD

import java.util.Arrays;

class GameOfLife {
    public int[][] tick(int[][] grid){
        int[][] nextGen = Arrays.stream(grid).map(int[]::clone).toArray(int[][]::new);
        for (int row = 0; row < grid.length; row++) {
            for (int col = 0; col < grid[row].length; col++) {
                switch (countNeighbors(grid, row, col)) {
                    case 2:
                        break;
                    case 3:
                        nextGen[row][col] = 1;
                        break;
                    default:
                        nextGen[row][col] = 0;
                }
            }
        }
        return nextGen;
    }

    private int countNeighbors(int[][] grid, int row, int col) {
        int total = 0;
        if (row != 0) total += sumRow(grid, row, col, row - 1);
        total += sumRow(grid, row, col, row);
        if (row != grid.length - 1) total += sumRow(grid, row, col, row + 1);
        return total;
    }

    private int sumRow(int[][] grid, int row, int col, int targetRow) {
        int sum = 0;
        if (col != 0) sum += grid[targetRow][col - 1];
        if (row != targetRow) sum += grid[targetRow][col];
        if (col != grid[targetRow].length - 1) sum += grid[targetRow][col + 1];
        return sum;
    }
}
