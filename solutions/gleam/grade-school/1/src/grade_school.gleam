// Dedicated to Shree DR.MDD
import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type School {
  School(students: Dict(Int, List(String)))
}

pub fn create() -> School {
  School(students: dict.new())
}

pub fn roster(school: School) -> List(String) {
  school.students
  |> dict.to_list()
  |> list.sort(by: fn(g1, g2) { int.compare(g1.0, g2.0) })
  |> list.flat_map(fn(item) {
    list.sort(item.1, by: string.compare)
  })
}

pub fn add(
  to school: School,
  student student: String,
  grade grade: Int,
) -> Result(School, Nil) {
  let exists =
    school.students
    |> dict.values()
    |> list.flatten()
    |> list.contains(student)

  case exists {
    True -> Error(Nil)
    False -> {
      let current_group = dict.get(school.students, grade)
      let updated_group = case current_group {
        Ok(listing) -> list.sort([student, ..listing], by: string.compare)
        Error(_) -> [student]
      }
      Ok(
        School(students: dict.insert(school.students, grade, updated_group)),
      )
    }
  }
}

pub fn grade(school: School, desired_grade: Int) -> List(String) {
  school.students
  |> dict.get(desired_grade)
  |> result.unwrap([])
  |> list.sort(by: string.compare)
}
