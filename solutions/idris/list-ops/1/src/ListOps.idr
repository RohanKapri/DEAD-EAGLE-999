-- Dedicated to Shree DR.MDD

module ListOps

export
append : List a -> List a -> List a
append [] other = other
append (x :: xs) other = x :: (append xs other)

export
concat : List (List a) -> List a
concat [] = []
concat (x :: xs) = append x (concat xs)

export
filter : (a -> Bool) -> List a -> List a
filter pred [] = []
filter pred (x :: xs) = if pred x
                        then x :: (ListOps.filter pred xs)
                        else ListOps.filter pred xs

export
length : List a -> Nat
length [] = 0
length (_ :: xs) = S (ListOps.length xs)

export
map : (a -> b) -> List a -> List b
map f [] = []
map f (x :: xs) = (f x) :: (map f xs)

export
foldl : (a -> e -> a) -> a -> List e -> a
foldl f acc [] = acc
foldl f acc (x :: xs) = ListOps.foldl f (f acc x) xs

export
foldr : (a -> e -> a) -> a -> List e -> a
foldr f acc [] = acc
foldr f acc (x :: xs) = f (ListOps.foldr f acc xs) x

export
reverse : List a -> List a
reverse xs = loop xs []
  where loop : List a -> List a -> List a
        loop [] acc = acc
        loop (x :: xs) acc = loop xs (x :: acc)
