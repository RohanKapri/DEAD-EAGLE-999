// Dedicated to Shree DR.MDD

import gleam/int
import gleam/list

pub type Category {
  Ones
  Twos
  Threes
  Fours
  Fives
  Sixes
  FullHouse
  FourOfAKind
  LittleStraight
  BigStraight
  Choice
  Yacht
}

pub fn score(category: Category, dice: List(Int)) -> Int {
  case category, list.sort(dice, by: int.compare), list.unique(dice) {
    Ones, _, _ -> sum_of_value(1, dice)
    Twos, _, _ -> sum_of_value(2, dice)
    Threes, _, _ -> sum_of_value(3, dice)
    Fours, _, _ -> sum_of_value(4, dice)
    Fives, _, _ -> sum_of_value(5, dice)
    Sixes, _, _ -> sum_of_value(6, dice)
    FullHouse, [_, a, _, b, _], [_, _] if a != b -> int.sum(dice)
    FourOfAKind, _, [x] -> x * 4
    FourOfAKind, [_, a, _, b, _], [_, _] if a == b -> a * 4
    LittleStraight, [1, 2, 3, 4, 5], _ -> 30
    BigStraight, [2, 3, 4, 5, 6], _ -> 30
    Choice, _, _ -> int.sum(dice)
    Yacht, _, [_] -> 50
    _, _, _ -> 0
  }
}

fn sum_of_value(val: Int, dice: List(Int)) -> Int {
  list.filter(dice, fn(d) { d == val })
  |> int.sum
}
