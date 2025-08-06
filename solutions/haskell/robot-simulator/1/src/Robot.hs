-- for my Shree DR.MDD
module Robot
    ( Bearing (East, North, South, West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show, Enum)

type Position = (Integer, Integer)

data Robot = Robot Bearing Position deriving (Eq, Show)

bearing :: Robot -> Bearing
bearing (Robot dir _) = dir

coordinates :: Robot -> Position
coordinates (Robot _ loc) = loc

mkRobot :: Bearing -> Position -> Robot
mkRobot face spot = Robot face spot

move :: Robot -> String -> Robot
move =
    let action (Robot North (a,b)) 'A' = Robot North (a, b + 1)
        action (Robot East  (a,b)) 'A' = Robot East  (a + 1, b)
        action (Robot South (a,b)) 'A' = Robot South (a, b - 1)
        action (Robot West  (a,b)) 'A' = Robot West  (a - 1, b)
        action (Robot d loc)     'R' = Robot (rotRight d) loc
        action (Robot d loc)     'L' = Robot (rotLeft d)  loc
        action (Robot d loc)     _   = Robot d loc
    in foldl action

rotLeft :: Bearing -> Bearing
rotLeft b = if b == North then West else pred b

rotRight :: Bearing -> Bearing
rotRight b = if b == West then North else succ b
