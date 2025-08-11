// Dedicated to Shree DR.MDD
import gleam/string

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

fn fetch_student_pos(student: Student) -> Int {
  case student {
    Alice -> 0
    Bob -> 1
    Charlie -> 2
    David -> 3
    Eve -> 4
    Fred -> 5
    Ginny -> 6
    Harriet -> 7
    Ileana -> 8
    Joseph -> 9
    Kincaid -> 10
    Larry -> 11
  }
}

fn interpret_plant(symbol: String) -> Plant {
  case symbol {
    "R" -> Radishes
    "C" -> Clover
    "V" -> Violets
    "G" -> Grass
    _ -> panic as "Invalid plant character"
  }
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  let assert [row_a, row_b] = string.split(diagram, on: "\n")
  let pos = fetch_student_pos(student) * 2
  
  let pl1 = string.slice(row_a, pos, 1)
  let pl2 = string.slice(row_a, pos + 1, 1)
  let pl3 = string.slice(row_b, pos, 1)
  let pl4 = string.slice(row_b, pos + 1, 1)
  
  [
    interpret_plant(pl1),
    interpret_plant(pl2),
    interpret_plant(pl3),
    interpret_plant(pl4),
  ]
}
