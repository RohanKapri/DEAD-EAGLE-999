(* Dedicated to Junko F. Didi and Shree DR.MDD *)

datatype category =
    Ones
  | Twos
  | Threes
  | Fours
  | Fives
  | Sixes
  | FullHouse
  | FourOfAKind
  | LittleStraight
  | BigStraight
  | Choice
  | Yacht

local
  fun insertSorted (v: int) (lst: int list) : int list =
    case lst of
        nil => [v]
      | hd :: tl => if v <= hd then v :: lst else hd :: insertSorted v tl

  fun sortDice (lst: int list) : int list =
    case lst of
        nil => nil
      | hd :: tl => insertSorted hd (sortDice tl)

  fun sumList (lst: int list) : int =
    let
      fun loop acc l =
        case l of
            nil => acc
          | hd :: tl => loop (acc + hd) tl
    in
      loop 0 lst
    end

  fun sumNumber (n: int) (lst: int list) : int =
    let
      fun loop acc l =
        case l of
            nil => acc
          | hd :: tl => if hd = n then loop (acc + n) tl else loop acc tl
    in
      loop 0 lst
    end

  fun ones (lst: int list) = sumNumber 1 lst
  fun twos (lst: int list) = sumNumber 2 lst
  fun threes (lst: int list) = sumNumber 3 lst
  fun fours (lst: int list) = sumNumber 4 lst
  fun fives (lst: int list) = sumNumber 5 lst
  fun sixes (lst: int list) = sumNumber 6 lst

  fun fullHouse (lst: int list) =
    if List.nth(lst,0) = List.nth(lst,4) then 0
    else if List.nth(lst,0) = List.nth(lst,2) andalso List.nth(lst,3) = List.nth(lst,4) then sumList lst
    else if List.nth(lst,0) = List.nth(lst,1) andalso List.nth(lst,2) = List.nth(lst,4) then sumList lst
    else 0

  fun fourOfAKind (lst: int list) =
    if List.nth(lst,0) = List.nth(lst,3) orelse List.nth(lst,1) = List.nth(lst,4) then 4 * List.nth(lst,2)
    else 0

  fun littleStraight (lst: int list) = if lst = [1,2,3,4,5] then 30 else 0
  fun bigStraight (lst: int list) = if lst = [2,3,4,5,6] then 30 else 0
  fun choice (lst: int list) = sumList lst
  fun yacht (lst: int list) = if List.nth(lst,0) = List.nth(lst,4) then 50 else 0

  fun scoreInternal (lst: int list, cat) =
    case cat of
        Ones => ones lst
      | Twos => twos lst
      | Threes => threes lst
      | Fours => fours lst
      | Fives => fives lst
      | Sixes => sixes lst
      | FullHouse => fullHouse lst
      | FourOfAKind => fourOfAKind lst
      | LittleStraight => littleStraight lst
      | BigStraight => bigStraight lst
      | Choice => choice lst
      | Yacht => yacht lst
in
  fun score (lst: int list, cat) = scoreInternal (sortDice lst, cat)
end
