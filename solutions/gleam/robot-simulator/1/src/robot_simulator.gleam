import gleam/list
import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  list.fold(
    string.to_graphemes(instructions),
    Robot(direction, position),
    fn(robot, instruction) {
      case instruction {
        "R" -> turn_right(robot)
        "L" -> turn_left(robot)
        "A" -> advance(robot)
        _ -> robot
      }
    },
  )
}

fn turn_right(robot: Robot) -> Robot {
  case robot {
    Robot(North, position) -> Robot(East, position)
    Robot(East, position) -> Robot(South, position)
    Robot(South, position) -> Robot(West, position)
    Robot(West, position) -> Robot(North, position)
  }
}

fn turn_left(robot: Robot) -> Robot {
  case robot {
    Robot(North, position) -> Robot(West, position)
    Robot(West, position) -> Robot(South, position)
    Robot(South, position) -> Robot(East, position)
    Robot(East, position) -> Robot(North, position)
  }
}

fn advance(robot: Robot) -> Robot {
  case robot {
    Robot(North, Position(x, y)) -> Robot(North, Position(x, y + 1))
    Robot(South, Position(x, y)) -> Robot(South, Position(x, y - 1))
    Robot(East, Position(x, y)) -> Robot(East, Position(x + 1, y))
    Robot(West, Position(x, y)) -> Robot(West, Position(x - 1, y))
  }
}