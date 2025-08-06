module School (School, add, empty, grade, sorted) where
import qualified Data.IntMap as M
import qualified Data.List as L
newtype School = School (M.IntMap [String])
add :: Int -> String -> School -> School
add gradeNum student (School roster) = School $ M.insertWith (+++) gradeNum (L.singleton student) roster
    where
        x +++ y = L.insert (head x) y
empty :: School
empty = School M.empty
grade :: Int -> School -> [String]
grade gradeNum (School roster) = M.findWithDefault [] gradeNum roster
sorted :: School -> [(Int, [String])]
sorted (School school) = M.toAscList school
