import gleam/list
import gleam/string

fn get_ordinal(n: Int) -> String {
  case n {
    1 -> "first"
    2 -> "second"
    3 -> "third"
    4 -> "fourth"
    5 -> "fifth"
    6 -> "sixth"
    7 -> "seventh"
    8 -> "eighth"
    9 -> "ninth"
    10 -> "tenth"
    11 -> "eleventh"
    12 -> "twelfth"
    _ -> ""
  }
}

const gifts = [
  "twelve Drummers Drumming",
  "eleven Pipers Piping",
  "ten Lords-a-Leaping",
  "nine Ladies Dancing",
  "eight Maids-a-Milking",
  "seven Swans-a-Swimming",
  "six Geese-a-Laying",
  "five Gold Rings",
  "four Calling Birds",
  "three French Hens",
  "two Turtle Doves",
  "a Partridge in a Pear Tree",
]

pub fn verse(number: Int) -> String {
  let ordinal = get_ordinal(number)

  // Get verse gifts
  let verse_gifts = case number {
    1 -> {
      case list.last(gifts) {
        Ok(last_gift) -> [last_gift]
        Error(_) -> []
      }
    }

    n -> {
      list.drop(gifts, 12 - n)
      |> list.map(fn(gift) {
        case gift {
          "a Partridge in a Pear Tree" -> "and " <> gift
          other -> other
        }
      })
    }
  }

  "On the " <> ordinal <> " day of Christmas my true love gave to me: " <> 
  string.join(verse_gifts, ", ") <> "."
}

pub fn lyrics(from starting_verse: Int, to ending_verse: Int) -> String {
  list.range(from: starting_verse, to: ending_verse)
  |> list.map(verse)
  |> string.join("\n")
}