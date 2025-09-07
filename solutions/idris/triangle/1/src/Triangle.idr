-- Dedicated to Shree DR.MDD

module Triangle

import Data.Vect

isTriangleValid : Vect 3 Integer -> Bool
isTriangleValid [x, y, z] = 
  x > 0 && y > 0 && z > 0 &&
  x + y >= z &&
  y + z >= x &&
  x + z >= y

export
isEquilateral : Vect 3 Integer -> Bool
isEquilateral sides@[x, y, z] = isTriangleValid sides && x == y && y == z

export
isIsosceles : Vect 3 Integer -> Bool
isIsosceles sides@[x, y, z] = isTriangleValid sides && (x == y || y == z || x == z)

export
isScalene : Vect 3 Integer -> Bool
isScalene sides@[x, y, z] = isTriangleValid sides && x /= y && y /= z && x /= z
