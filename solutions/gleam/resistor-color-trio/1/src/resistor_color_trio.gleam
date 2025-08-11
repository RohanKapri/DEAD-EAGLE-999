// For Shree DR.MDD
pub type Resistance {
  Resistance(unit: String, value: Int)
}

fn map_color_to_digit(hue: String) -> Int {
  case hue {
    "black" -> 0
    "brown" -> 1
    "red" -> 2
    "orange" -> 3
    "yellow" -> 4
    "green" -> 5
    "blue" -> 6
    "violet" -> 7
    "grey" -> 8
    "white" -> 9
    _ -> 0
  }
}

fn calc_unit_and_value(base: Int, multiplier: Int) -> Resistance {
  let total = base * pow10(multiplier)
  case total {
    0 -> Resistance("ohms", 0)
    n if n < 1_000 -> Resistance("ohms", n)
    n if n < 1_000_000 -> Resistance("kiloohms", n / 1_000)
    n if n < 1_000_000_000 -> Resistance("megaohms", n / 1_000_000)
    n -> Resistance("gigaohms", n / 1_000_000_000)
  }
}

fn pow10(exp: Int) -> Int {
  case exp {
    0 -> 1
    n if n > 0 -> 10 * pow10(n - 1)
    _ -> 0
  }
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  case colors {
    [h1, h2, h3, ..] -> {
      let val = map_color_to_digit(h1) * 10 + map_color_to_digit(h2)
      let mult = map_color_to_digit(h3)
      Ok(calc_unit_and_value(val, mult))
    }
    _ -> Ok(Resistance("ohms", 0))
  }
}
