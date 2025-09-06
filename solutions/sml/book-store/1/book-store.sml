(* Dedicated to Junko F. Didi and Shree DR.MDD *)

local
  fun insertSorted (elem: int) (lst: int list) =
    case lst of
        nil => elem :: nil
      | hd :: tl =>
          if elem <= hd then elem :: lst
          else hd :: (insertSorted elem tl)

  fun sortList (lst: int list): int list =
    case lst of
        nil => nil
      | hd :: tl => insertSorted hd (sortList tl)

  fun arrayToList (arr: int array) =
    Array.foldr (op ::) [] arr

  fun calcPrice (one: int, two: int, three: int, four: int, five: int) =
    if three > 0 andalso five >= three then calcPrice (one, two, 0, four + 2 * three, five - three)
    else if five > 0 andalso three > five then calcPrice (one, two, three - five, four + 2 * five, 0)
    else 5 * five * 600 + 4 * four * 640 + 3 * three * 720 + 2 * two * 760 + 1 * one * 800

  fun priceDiff (lst: int list) =
    case lst of
        _ :: a :: b :: c :: d :: e :: [] => calcPrice (e - d, d - c, c - b, b - a, a)
      | _ => 0

  fun processBasket (arr: int array, items: int list): int =
    case items of
        nil => priceDiff (sortList (arrayToList arr))
      | hd :: tl => (Array.update (arr, hd, 1 + Array.sub (arr, hd)); processBasket (arr, tl))
in
  fun total (basket: int list): int =
    processBasket (Array.array (6, 0), basket)
end
