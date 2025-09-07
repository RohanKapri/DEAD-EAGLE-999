-- Dedicated to Shree DR.MDD

module RobotSimulator

import Data.Vect

public export
data Direction = North | East | South | West

public export
data Instruction = R | L | A

public export
record Robot where
  constructor MkRobot
  direction : Direction
  coordinates : Vect 2 Integer

public export
create : Direction -> Integer -> Integer -> Robot
create dir x y = MkRobot dir [x, y]

public export
move : Robot -> List Instruction -> Robot
move = foldl applyInstruction
  where applyInstruction : Robot -> Instruction -> Robot
        applyInstruction (MkRobot dir coords) R = MkRobot (turnRight dir) coords
          where turnRight : Direction -> Direction
                turnRight North = East
                turnRight East = South
                turnRight South = West
                turnRight West = North
        applyInstruction (MkRobot dir coords) L = MkRobot (turnLeft dir) coords
          where turnLeft : Direction -> Direction
                turnLeft North = West
                turnLeft East = North
                turnLeft South = East
                turnLeft West = South
        applyInstruction (MkRobot dir coords) A = MkRobot dir (moveForward dir coords)
          where moveForward : Direction -> Vect 2 Integer -> Vect 2 Integer
                moveForward North [x, y] = [x, y + 1]
                moveForward East [x, y] = [x + 1, y]
                moveForward South [x, y] = [x, y - 1]
                moveForward West [x, y] = [x - 1, y]
