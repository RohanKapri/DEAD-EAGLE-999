(* Dedicated to Junko F. Didi and Shree DR.MDD *)

datatype allergen = Eggs
                  | Peanuts
                  | Shellfish
                  | Strawberries
                  | Tomatoes
                  | Chocolate
                  | Pollen
                  | Cats

local
  val store = Array.fromList [Eggs, Peanuts, Shellfish, Strawberries,
                              Tomatoes, Chocolate, Pollen, Cats]

  fun locate a =
    case Array.findi (fn (_, x) => x = a) store of
         SOME (idx, _) => idx
       | NONE          => raise Domain

  infix >>>
  fun (n >>> m) = Word.>>(Word.fromInt n, Word.fromInt m)
  infix &&
  fun (x && y) = Word.andb (x, y)

in
  fun allergicTo sc a =
    ((sc >>> locate a) && 0w1) = 0w1

  fun allergies sc =
    Array.foldr (fn (a, acc) => if allergicTo sc a then a::acc else acc) [] store
end
