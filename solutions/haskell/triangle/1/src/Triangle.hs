module Triangle (TriangleType(..), triangleType) where

data TriangleType = Equilateral
                  | Isosceles
                  | Scalene
                  | Illegal
                  deriving (Eq, Show)

triangleType :: (Num a, Ord a) => a -> a -> a -> TriangleType
triangleType a b c
    | a <= 0         = Illegal
    | b <= 0         = Illegal
    | c <= 0         = Illegal
    | (a+b) <= c     = Illegal
    | (b+c) <= a     = Illegal
    | (c+a) <= b     = Illegal
    | ab && bc && ca = Equilateral
    | ab || bc || ca = Isosceles
    | otherwise      = Scalene
    where
        ab = a == b
        bc = b == c
        ca = c == a