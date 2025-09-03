import java.util.*;
import java.util.List;
import java.awt.*;
class MazeGenerator {
    static class Cell {

        public final Map<Direction, Boolean> walls;
        public boolean visited = false;
        public Cell() {
            walls = new HashMap<>();
            walls.put(Direction.UP, true);
            walls.put(Direction.DOWN, true);
            walls.put(Direction.LEFT, true);
            walls.put(Direction.RIGHT, true);
        }
    }
    enum Direction {
        UP(0, -1),
        DOWN(0, 1),
        LEFT(-1, 0),
        RIGHT(1, 0);
        public final int xMove, yMove;
        private Direction opposite;
        static {
            UP.opposite = DOWN;
            DOWN.opposite = UP;
            LEFT.opposite = RIGHT;
            RIGHT.opposite = LEFT;
        }
        Direction(int xMove, int yMove) {
            this.xMove = xMove;
            this.yMove = yMove;
        }
    }

    /*
    From top to bottom:
    !up && !down
    up && !down
    !up && down
    up && down

    From left to right:
    !left && !right    left && !right    !left && right    left && right
     */
    private static final char[][] CORNER_LOOKUP = {
            {' ', '─', '─', '─'},
            {'│', '┘', '└', '┴'},
            {'│', '┐', '┌', '┬'},
            {'│', '┤', '├', '┼'}
    };

    private static final Random random = new Random();
    private final Map<Integer, char[][]> seeds = new HashMap<>();

    public char[][] generatePerfectMaze(int rows, int columns) {
        if (rows < 5 || rows > 100 || columns < 5 || columns > 100) throw new IllegalArgumentException();
        Cell[][] maze = new Cell[rows][columns];
        for (int i = 0; i < rows; i++)
            for (int j = 0; j < columns; j++)
                maze[i][j] = new Cell();
        Point entrance = new Point(0, random.nextInt(rows)), exit = new Point(columns - 1, random.nextInt(rows));
        Deque<Point> stack = new ArrayDeque<>();
        stack.push(entrance);
        maze[entrance.y][entrance.x].visited = true;
        while (!stack.isEmpty()) {
            Point current = stack.peek();
            List<Map.Entry<Direction, Point>> possiblePaths = getPossiblePaths(maze, current);
            if (possiblePaths.isEmpty()) {
                stack.pop();
            } else {
                Map.Entry<Direction, Point> chosen = possiblePaths.get(random.nextInt(possiblePaths.size()));
                Direction direction = chosen.getKey();
                Point point = chosen.getValue();

                maze[current.y][current.x].walls.put(direction, false);
                Cell next = maze[point.y][point.x];
                next.walls.put(direction.opposite, false);
                next.visited = true;
                stack.push(point);
            }
        }
        return convertMaze(maze, entrance, exit);
    }

    public char[][] generatePerfectMaze(int rows, int columns, int seed) {
        seeds.putIfAbsent(seed, generatePerfectMaze(rows, columns));
        return seeds.get(seed);
    }
    private List<Map.Entry<Direction, Point>> getPossiblePaths(Cell[][] maze, Point point) {
        return Arrays.stream(Direction.values())
            .map(direction -> Map.entry(direction, new Point(point.x + direction.xMove, point.y + direction.yMove)))
            .filter(entry -> isValidPoint(maze, entry.getValue()))
            .toList();
    }

    private boolean isValidPoint(Cell[][] maze, Point point) {
        return point.x >= 0 && point.x < maze[0].length
            && point.y >= 0 && point.y < maze.length
            && !maze[point.y][point.x].visited;
    }

    private char[][] convertMaze(Cell[][] maze, Point entrance, Point exit) {
        int cellRows = maze.length, cellColumns = maze[0].length,
                charRows = cellRows * 2 + 1, charColumns = cellColumns * 2 + 1;
        char[][] result = new char[charRows][charColumns];
        result[0][0] = '┌';
        for (int j = 0; j < cellColumns; j++) {
            result[0][j * 2 + 1] = '─';
            result[0][j * 2 + 2] = j == cellColumns - 1 ? '┐' :
                    maze[0][j].walls.get(Direction.RIGHT) ? '┬' : '─';
        }
        for (int i = 0; i < cellRows; i++) {
            int charRow = i * 2 + 1;

            result[charRow][0] = i == entrance.y ? '⇨' : '│';
            result[charRow + 1][0] = i == cellRows - 1 ? '└' :
                    maze[i][0].walls.get(Direction.DOWN) ? '├' : '│';

            for (int j = 0; j < cellColumns; j++) {
                int charColumn = j * 2 + 1;
                Cell cell = maze[i][j];

                result[charRow][charColumn] = ' ';
                result[charRow][charColumn + 1] = new Point(j, i).equals(exit) ? '⇨' :
                        cell.walls.get(Direction.RIGHT) ? '│' : ' ';
                result[charRow + 1][charColumn] = cell.walls.get(Direction.DOWN) ? '─' : ' ';
                result[charRow + 1][charColumn + 1] = convertCorner(maze, cell.walls, i + 1, j + 1);
            }
        }
        return result;
    }

    private char convertCorner(Cell[][] maze, Map<Direction, Boolean> currentCellWalls, int nextRow, int nextColumn) {
        int rows = maze.length, columns = maze[0].length;
        boolean up = currentCellWalls.get(Direction.RIGHT), left = currentCellWalls.get(Direction.DOWN);
        if (nextRow >= rows && nextColumn >= columns) return '┘';
        if (nextRow >= rows) return up ? '┴' : '─';
        if (nextColumn >= columns) return left ? '┤' : '│';
        Map<Direction, Boolean> nextCellWalls = maze[nextRow][nextColumn].walls;
        boolean right = nextCellWalls.get(Direction.UP), down = nextCellWalls.get(Direction.LEFT);

        int lookUpRow = (up ? 1 : 0) + (down ? 2 : 0), lookUpColumn = (left ? 1 : 0) + (right ? 2 : 0);
        return CORNER_LOOKUP[lookUpRow][lookUpColumn];
    }
}