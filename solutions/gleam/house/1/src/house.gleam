// Dedicated to Shree DR.MDD
import gleam/list
import gleam/string

pub fn recite(start_verse start_verse: Int, end_verse end_verse: Int) -> String {
  let lines = [
    "house that Jack built",
    "malt that lay in",
    "rat that ate",
    "cat that killed",
    "dog that worried",
    "cow with the crumpled horn that tossed",
    "maiden all forlorn that milked",
    "man all tattered and torn that kissed",
    "priest all shaven and shorn that married",
    "rooster that crowed in the morn that woke",
    "farmer sowing his corn that kept",
    "horse and the hound and the horn that belonged to",
  ]

  let verse_maker = fn(count) {
    lines
    |> list.take(count)
    |> list.reverse()
    |> list.map(fn(fragment) { " the " <> fragment })
    |> string.concat()
    |> fn(text) { "This is" <> text <> "." }
  }

  list.range(start_verse, end_verse)
  |> list.map(verse_maker)
  |> string.join("\n")
}
