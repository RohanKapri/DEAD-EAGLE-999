import Bearing.Direction
import Robot.Point

object Robot {
  type Point = (Int, Int)

  def operations(steps: String) = steps.map { s =>
    s match {
      case 'L' => Operation(r => Robot(r.bearing.left, r.coordinates))
      case 'R' => Operation(r => Robot(r.bearing.right, r.coordinates))
      case 'A' =>
        Operation(r => Robot(r.bearing, r.bearing.advance(r.coordinates)))
    }
  }
}

case class Operation(move: Robot => Robot)

case class Robot(val bearing: Direction, val coordinates: Point) {
  def simulate(steps: String): Robot =
    Robot
      .operations(steps)
      .foldLeft(this)((r, op) => op.move(r))

  def turnLeft: Robot = Robot(this.bearing.left, this.coordinates)
  def turnRight: Robot = Robot(this.bearing.right, this.coordinates)
  def advance: Robot = Robot(this.bearing, this.bearing.advance(coordinates))
}

object Bearing {
  sealed trait Direction {
    def left: Direction
    def right: Direction
    def advance: Point => Point
  }
  case object East extends Direction {
    override val left: Direction = North
    override val right: Direction = South
    override val advance: Point => Point = { case (x, y) => (x + 1, y) }
  }
  case object West extends Direction {
    override val left: Direction = South
    override val right: Direction = North
    override val advance: Point => Point = { case (x, y) => (x - 1, y) }
  }
  case object North extends Direction {
    override val left: Direction = West
    override val right: Direction = East
    override val advance: Point => Point = { case (x, y) => (x, y + 1) }
  }
  case object South extends Direction {
    override val left: Direction = East
    override val right: Direction = West
    override val advance: Point => Point = { case (x, y) => (x, y - 1) }
  }
}