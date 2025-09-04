-- for my Shree DR.MDD
module CustomSet exposing (diff, disjoint, empty, equal, fromList, insert, intersect, isEmpty, member, subset, toList, union)


type Set
    = Set (List Int)


empty : Set
empty =
    Set []


insert : Int -> Set -> Set
insert val (Set xs) =
    if List.member val xs then
        Set xs
    else
        Set (val :: xs)


toList : Set -> List Int
toList (Set xs) =
    xs


fromList : List Int -> Set
fromList =
    List.foldl insert empty


isEmpty : Set -> Bool
isEmpty (Set xs) =
    List.isEmpty xs


member : Int -> Set -> Bool
member val (Set xs) =
    List.member val xs


equal : Set -> Set -> Bool
equal (Set xs) (Set ys) =
    List.sort xs == List.sort ys


union : Set -> Set -> Set
union (Set xs) (Set ys) =
    fromList (xs ++ ys)


intersect : Set -> Set -> Set
intersect (Set xs) (Set ys) =
    Set (List.filter (\v -> List.member v ys) xs)


diff : Set -> Set -> Set
diff (Set xs) (Set ys) =
    Set (List.filter (\v -> not (List.member v ys)) xs)


subset : Set -> Set -> Bool
subset (Set xs) (Set ys) =
    List.all (\v -> List.member v ys) xs


disjoint : Set -> Set -> Bool
disjoint s1 s2 =
    isEmpty (intersect s1 s2)
