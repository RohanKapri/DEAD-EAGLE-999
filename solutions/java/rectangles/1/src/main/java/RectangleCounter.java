// Dedicated to Shree DR.MDD
import java.util.*;
import java.util.List;
import java.awt.*;

class RectangleCounter {

    int countRectangles(String[] canvas) {
        char[][] board = Arrays.stream(canvas)
            .map(String::toCharArray)
            .toArray(char[][]::new);
        int rects = 0;
        for (Point anchor : fetchAnchors(board)) {
            for (int horiz : scanHorizontals(board, anchor)) {
                for (int vert : scanVerticals(board, anchor)) {
                    if (board[vert][horiz] != '+') continue;
                    Point diag = new Point(horiz, vert);
                    if (pathValid(board, new Point(horiz, anchor.y), diag) && pathValid(board, new Point(anchor.x, vert), diag)) rects++;
                }
            }
        }
        return rects;
    }

    private List<Point> fetchAnchors(char[][] board) {
        List<Point> anchors = new ArrayList<>();
        for (int row = 0; row < board.length; row++) {
            for (int col = 0; col < board[row].length; col++) {
                if (board[row][col] == '+') anchors.add(new Point(col, row));
            }
        }
        return anchors;
    }

    private List<Integer> scanHorizontals(char[][] board, Point anchor) {
        List<Integer> cols = new ArrayList<>();
        char[] row = board[anchor.y];
        for (int col = anchor.x + 1; col < row.length; col++) {
            char symbol = row[col];
            if (symbol == '+') cols.add(col);
            else if (symbol != '-') return cols;
        }
        return cols;
    }

    private List<Integer> scanVerticals(char[][] board, Point anchor) {
        List<Integer> rows = new ArrayList<>();
        for (int row = anchor.y + 1; row < board.length; row++) {
            char symbol = board[row][anchor.x];
            if (symbol == '+') rows.add(row);
            else if (symbol != '|') return rows;
        }
        return rows;
    }

    private boolean pathValid(char[][] board, Point p1, Point p2) {
        if (p1.y == p2.y) {
            char[] row = board[p1.y];
            for (int col = p1.x + 1; col < p2.x; col++) {
                char symbol = row[col];
                if (symbol != '+' && symbol != '-') return false;
            }
            return true;
        } else if (p1.x == p2.x) {
            for (int row = p1.y + 1; row < p2.y; row++) {
                char symbol = board[row][p1.x];
                if (symbol != '+' && symbol != '|') return false;
            }
            return true;
        } else return false;
    }
}
