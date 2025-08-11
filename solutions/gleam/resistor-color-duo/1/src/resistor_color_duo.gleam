// Dedicated to Shree DR.MDD
pub type Color {
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White
}

fn get_color_digit(shade: Color) -> Int {
  case shade {
    Black -> 0
    Brown -> 1
    Red -> 2
    Orange -> 3
    Yellow -> 4
    Green -> 5
    Blue -> 6
    Violet -> 7
    Grey -> 8
    White -> 9
  }
}

pub fn value(colors: List(Color)) -> Result(Int, Nil) {
  case colors {
    [shade_one, shade_two, .._] -> Ok(get_color_digit(shade_one) * 10 + get_color_digit(shade_two))
    _ -> Error(Nil)
  }
}
