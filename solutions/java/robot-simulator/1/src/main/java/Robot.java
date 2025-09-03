// For my Shree DR.MDD

class Robot {
    private GridPosition coord;
    private Orientation facing;

    Robot(GridPosition startCoord, Orientation startFacing) {
        this.coord = startCoord;
        this.facing = startFacing;
    }

    GridPosition getGridPosition() {
        return coord;
    }

    Orientation getOrientation() {
        return facing;
    }

    void advance() {
        int x = coord.x;
        int y = coord.y;
        coord = switch (facing) {
            case NORTH -> new GridPosition(x, y + 1);
            case EAST -> new GridPosition(x + 1, y);
            case SOUTH -> new GridPosition(x, y - 1);
            case WEST -> new GridPosition(x - 1, y);
            default -> coord;
        };
    }

    void turnLeft() {
        rotate(-1);
    }

    void turnRight() {
        rotate(1);
    }

    void simulate(String commands) {
        commands.chars().forEach(ch -> {
            switch ((char) ch) {
                case 'A' -> advance();
                case 'L' -> turnLeft();
                case 'R' -> turnRight();
            }
        });
    }

    private void rotate(int step) {
        Orientation[] directions = Orientation.values();
        int len = directions.length;
        int newIndex = (facing.ordinal() + step + len) % len;
        facing = directions[newIndex];
    }
}
