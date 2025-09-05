// Shree DR.MDD
import Orientation.*

class Robot(initialPos: GridPosition = GridPosition(0, 0), initialDir: Orientation = NORTH) {

    var gridPosition: GridPosition = initialPos
        private set

    var orientation: Orientation = initialDir
        private set

    fun advance() {
        gridPosition = with(gridPosition) {
            when (orientation) {
                NORTH -> copy(y = y + 1)
                EAST -> copy(x = x + 1)
                SOUTH -> copy(y = y - 1)
                WEST -> copy(x = x - 1)
            }
        }
    }

    fun turnLeft() {
        orientation = when (orientation) {
            NORTH -> WEST
            EAST -> NORTH
            SOUTH -> EAST
            WEST -> SOUTH
        }
    }

    fun turnRight() {
        orientation = when (orientation) {
            NORTH -> EAST
            EAST -> SOUTH
            SOUTH -> WEST
            WEST -> NORTH
        }
    }

    fun simulate(commands: String) {
        commands.forEach { cmd ->
            when (cmd) {
                'L' -> turnLeft()
                'R' -> turnRight()
                'A' -> advance()
                else -> throw IllegalArgumentException("Invalid input $cmd")
            }
        }
    }
}
