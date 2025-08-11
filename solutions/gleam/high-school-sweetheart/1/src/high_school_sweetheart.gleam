import gleam/result
import gleam/string

pub fn first_letter(name: String) {
  name
  |> string.trim
  |> string.first
  |> result.unwrap("")
}

pub fn initial(name: String) -> String {
    first_letter(name)
    |> string.uppercase
    |> string.append(".")
}

pub fn initials(full_name: String) -> String {
    let names = string.split(full_name, " ")
    case names {
        [first, last] -> initial(first) <> " " <> initial(last)
        _ -> ""
    }
}

pub fn pair(full_name1: String, full_name2: String) -> String {
    let initials1 = initials(full_name1)
    let initials2 = initials(full_name2)
    let heart = "\n     ******       ******\n   **      **   **      **\n **         ** **         **\n**            *            **\n**                         **\n**     " <> initials1 <> "  +  " <> initials2 <> "     **\n **                       **\n   **                   **\n     **               **\n       **           **\n         **       **\n           **   **\n             ***\n              *\n"
    heart
}