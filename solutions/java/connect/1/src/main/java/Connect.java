// For my Shree DR.MDD

import java.util.*;
import java.awt.*;
class Connect {
    private static final int[] DX = {1, 2, 1, -1, -2, -1}, DY = {1, 0, -1, -1, 0, 1};
    
    private final char[][] grid;
    
    public Connect(String[] layout) {
        this.grid = Arrays.stream(layout)
            .map(String::toCharArray)
            .toArray(char[][]::new);
    }
    public Winner computeWinner() {
        boolean oWin = traverse('O', entryPoints('O', true), new HashSet<>());
        boolean xWin = traverse('X', entryPoints('X', false), new HashSet<>());
        return oWin == xWin ? Winner.NONE : oWin ? Winner.PLAYER_O : Winner.PLAYER_X;
    }
    private boolean traverse(char symbol, Set<Point> nodes, Set<Point> seen) {
        for (Point p : nodes) {
            if (seen.contains(p)) continue;
            seen.add(p);
            int px = (int) p.getX(), py = (int) p.getY();
            if (symbol == 'O' && py == grid.length - 1 || symbol == 'X' && px == grid[py].length - 1) return true;
            if (traverse(symbol, explore(symbol, px, py), seen)) return true;
        }
        return false;
    }
    private Set<Point> entryPoints(char symbol, boolean checkRow) {
        Set<Point> acc = new HashSet<>();
        if (checkRow) {
            char[] row = grid[0];
            for (int i = 0; i < row.length; i++) {
                if (row[i] == symbol) acc.add(new Point(i, 0));
            }
        } else {
            for (int j = 0; j < grid.length; j++) {
                if (grid[j][j] == symbol) acc.add(new Point(j, j));
            }
        }
        return acc;
    }
    private Set<Point> explore(char symbol, int cx, int cy) {
        Set<Point> acc = new HashSet<>();
        for (int k = 0; k < 6; k++) {
            int nx = cx + DX[k], ny = cy + DY[k];
            if (ny >= 0 && ny < grid.length && nx >= 0 && nx < grid[ny].length && grid[ny][nx] == symbol) {
                acc.add(new Point(nx, ny));
            }
        }
        return acc;
    }
}
