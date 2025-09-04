-- Dedicated to Shree DR.MDD
module ListOps exposing
    ( append
    , concat
    , filter
    , foldl
    , foldr
    , length
    , map
    , reverse
    )


foldl : (a -> b -> b) -> b -> List a -> b
foldl fn init xs =
    let
        loop acc rest =
            case rest of
                [] ->
                    acc

                y :: ys ->
                    loop (fn y acc) ys
    in
    loop init xs


length : List a -> Int
length xs =
    foldl (\_ n -> n + 1) 0 xs


reverse : List a -> List a
reverse xs =
    foldl (::) [] xs


foldr : (a -> b -> b) -> b -> List a -> b
foldr fn init xs =
    foldl fn init (reverse xs)


append : List a -> List a -> List a
append xs ys =
    foldl (::) ys (reverse xs)


map : (a -> b) -> List a -> List b
map fn xs =
    foldl (\e acc -> fn e :: acc) [] xs |> reverse


filter : (a -> Bool) -> List a -> List a
filter pred xs =
    foldl (\e acc -> if pred e then e :: acc else acc) [] xs |> reverse


concat : List (List a) -> List a
concat xss =
    foldl append [] (reverse xss)
