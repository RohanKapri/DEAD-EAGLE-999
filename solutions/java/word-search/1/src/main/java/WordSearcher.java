import java.util.*;
import java.util.function.*;
class WordSearcher {
    enum GridOrder {
        NORMAL,
        HORIZONTAL_FLIP,
        VERTICAL_FLIP,
        DIAGONAL_FLIP
    }
    
    Map<String, Optional<WordLocation>> search(final Set<String> words, final char[][] grid) {
        Map<String, Optional<WordLocation>> result = new HashMap<>();
        for (String word : words) {
            for (GridOrder order : GridOrder.values()) {
                PublicLocation location = searchWord(grid, word, order);
                if (location != null) {
                    result.put(word, Optional.of(new WordLocation(location.startCoord(), location.endCoord())));
                    break;
                }
            }
            result.putIfAbsent(word, Optional.empty());
        }
        return result;
    }
    private PublicLocation searchWord(char[][] grid, String word, GridOrder order) {
        char[][] transformedGrid;
        List<BiFunction<char[][], String, PublicLocation>> searchFunctions;
        TriFunction<PublicLocation, Integer, Integer, PublicLocation> locationTransform;
        switch (order) {
            case HORIZONTAL_FLIP:
                transformedGrid = reverseHorizontally(grid);
                searchFunctions = List.of(this::searchLeftToRight, this::searchTopLeftToBottomRight);
                locationTransform = this::reverseHorizontally;
                break;
            case VERTICAL_FLIP:
                transformedGrid = reverseVertically(grid);
                searchFunctions = List.of(this::searchTopToBottom, this::searchTopLeftToBottomRight);
                locationTransform = this::reverseVertically;
                break;
            case DIAGONAL_FLIP:
                transformedGrid = reverseHorizontally(reverseVertically(grid));
                searchFunctions = List.of(this::searchTopLeftToBottomRight);
                locationTransform = (location, rowCount, columnCount) -> reverseHorizontally(reverseVertically(location, rowCount, columnCount), rowCount, columnCount);
                break;
            default:
                transformedGrid = grid;
                searchFunctions = List.of(this::searchLeftToRight, this::searchTopToBottom, this::searchTopLeftToBottomRight);
                locationTransform = (location, rowCount, columnCount) -> location;
        }
        int rowCount = grid.length, columnCount = grid[0].length;
        for (BiFunction<char[][], String, PublicLocation> function : searchFunctions) {
            PublicLocation location = function.apply(transformedGrid, word);
            if (location != null) return locationTransform.apply(location, rowCount, columnCount);
        }
        return null;
    }
    private PublicLocation searchLeftToRight(char[][] grid, String word) {
        String[] rows = Arrays.stream(grid).map(String::new).toArray(String[]::new);
        for (int y = 0; y < rows.length; y++) {
            int x = rows[y].indexOf(word);
            if (x != -1) return getLocation(x + 1, y + 1, x + word.length(), y + 1);
        }
        return null;
    }
    private PublicLocation searchTopToBottom(char[][] grid, String word) {
        PublicLocation inversedLocation = searchLeftToRight(inverse(grid), word);
        if (inversedLocation == null) return inversedLocation;
        Pair startCoord = inversedLocation.startCoord(), endCoord = inversedLocation.endCoord();
        return getLocation(startCoord.getY(), startCoord.getX(), endCoord.getY(), endCoord.getX());
    }
    private PublicLocation searchTopLeftToBottomRight(char[][] grid, String word) {
        int rowCount = grid.length, columnCount = grid[0].length;
        for (int i = 0; i < rowCount + columnCount; i++) {
            StringBuilder sb = new StringBuilder();
            int startX = Integer.max(0, i - rowCount + 1), startY = Integer.max(0, rowCount - 1 - i), endX = Integer.min(columnCount - 1, i);
            for (int j = 0; j <= endX - startX; j++) {
                sb.append(grid[startY + j][startX + j]);
            }
            
            int matchStart = sb.toString().indexOf(word);
            if (matchStart != -1) {
                return getLocation(startX + matchStart + 1, startY + matchStart + 1, startX + matchStart + word.length(), startY + matchStart + word.length());
            }
        }
        return null;
    }
    private PublicLocation getLocation(int x1, int y1, int x2, int y2) {
        return new PublicLocation(new Pair(x1, y1), new Pair(x2, y2));
    }
    private char[][] inverse(char[][] grid) {
        int rowCount = grid.length, columnCount = grid[0].length;
        char[][] result = new char[columnCount][rowCount];
        for (int i = 0; i < rowCount; i++) {
            char[] row = grid[i];
            for (int j = 0; j < columnCount; j++) {
                result[j][i] = row[j];
            }
        }
        return result;
    }
    private char[][] reverseHorizontally(char[][] grid) {
        int rowCount = grid.length, columnCount = grid[0].length;
        char[][] result = new char[rowCount][columnCount];
        for (int i = 0; i < rowCount; i++) {
            char[] row = grid[i];
            char[] resultRow = result[i];
            for (int j = 0; j < columnCount; j++) {
                resultRow[j] = row[columnCount - j - 1];
            }
        }
        return result;
    }
    private PublicLocation reverseHorizontally(PublicLocation location, int rowCount, int columnCount) {
        Pair startCoord = location.startCoord(), endCoord = location.endCoord();
        return getLocation(columnCount - startCoord.getX() + 1, startCoord.getY(), columnCount - endCoord.getX() + 1, endCoord.getY());
    }
    private char[][] reverseVertically(char[][] grid) {
        int rowCount = grid.length;
        char[][] result = new char[rowCount][];
        for (int i = 0; i < rowCount; i++) {
            result[i] = grid[rowCount - i - 1].clone();
        }
        return result;
    }
    private PublicLocation reverseVertically(PublicLocation location, int rowCount, int columnCount) {
        Pair startCoord = location.startCoord(), endCoord = location.endCoord();
        return getLocation(startCoord.getX(), rowCount - startCoord.getY() + 1, endCoord.getX(), rowCount - endCoord.getY() + 1);
    }
}
@FunctionalInterface
interface TriFunction<T, U, V, R> {
    R apply(T t, U u, V v);
}
record PublicLocation(Pair startCoord, Pair endCoord) {};